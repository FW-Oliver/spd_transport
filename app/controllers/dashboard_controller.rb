class DashboardController < ApplicationController
  before_action :require_dashboard_access

  def index
    @requests = current_user.organization
                              .transport_requests
                              .includes(:location)
                              .order(created_at: :desc)
  end

  private

  def require_dashboard_access
    unless current_user&.admin? ||
           current_user&.transporter? ||
           current_user&.viewer?
      redirect_to root_path,
                  alert: "You are not authorized to access the dashboard."
    end
  end
end