class DashboardController < ApplicationController
  before_action :require_authentication
  before_action :require_viewer

 def index
  @locations = current_user.organization
                            .locations
                            .active
                            .order(:name)

  @requests = current_user.organization
                          .transport_requests
                          .where(status: %w[requested accepted in_transit])
                          .includes(:location)
                          .order(created_at: :asc)

  @selected_date =
    if params[:date].present?
      Date.parse(params[:date])
    else
      Date.current
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
                              performed_at: @selected_date.beginning_of_day..
                                            @selected_date.end_of_day
                            )
                            .order(performed_at: :desc)

  @activity_count = @activities.size
end

  private

  def require_viewer
    unless current_user&.viewer?
      redirect_to root_path,
                  alert: "You have no valid access. Please try to select the correct role."
    end
  end
end