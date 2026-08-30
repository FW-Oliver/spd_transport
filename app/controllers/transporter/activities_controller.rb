class Transporter::ActivitiesController < ApplicationController
  before_action :require_authentication
  before_action :require_transporter

  def index
    @selected_date =
      if params[:date].present?
        Date.parse(params[:date])
      else
        organization_today
      end

    @activities = current_user.organization
                          .transport_activities
                          .includes(
                            :user,
                            :transporter_action,
                            :location,
                            evidence_thumbnail_attachment: :blob
                          )
                          .where(
                            performed_at:
                              @selected_date.in_time_zone(organization_timezone).beginning_of_day..
                              @selected_date.in_time_zone(organization_timezone).end_of_day
                          )
                          .order(performed_at: :desc)

    @activity_count = @activities.size
  end

  def show
    @activity = current_user.organization
                        .transport_activities
                        .includes(:user, :transporter_action, :location)
                        .find(params[:id])

    @selected_date =
      @activity.performed_at.in_time_zone(organization_timezone).to_date

    unless @activity.evidence_photo.attached?
      redirect_to transporter_activities_path,
                  alert: "Photo evidence is not available."
    end
  end

  def create
    location = current_user.organization
                      .locations
                      .active
                      .find(params[:location_id])

    action = current_user.organization
                        .transporter_actions
                        .where(active: true)
                        .find(params[:transporter_action_id])

    activity = TransportActivity.new(
      organization: current_user.organization,
      location: location,
      transporter_action: action,
      user: current_user,
      performed_at: Time.current
    )

    if params[:photo].present?
      TransportActivityEvidenceGenerator.new(
        activity,
        params[:photo]
      ).call
    end

    if activity.save
      redirect_to transporter_location_path(location),
                  notice: "#{action.name} recorded."
    else
      redirect_to transporter_location_path(location),
                  alert: activity.errors.full_messages.to_sentence
    end
  end

  private

  def require_transporter
    unless current_user&.transporter?
      redirect_to root_path,
                  alert: "You are not authorized to access this page."
    end
  end
end
