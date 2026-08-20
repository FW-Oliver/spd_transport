class Transporter::ActivitiesController < ApplicationController
  before_action :require_authentication
  before_action :require_transporter

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

activity.photo.attach(params[:photo]) if params[:photo].present?

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