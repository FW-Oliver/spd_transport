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
  end

  private

  def require_viewer
    unless current_user&.viewer?
      redirect_to root_path,
                  alert: "You have no valid access. Please try to select the correct role."
    end
  end
end