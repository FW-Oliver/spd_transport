class Transporter::DashboardController < ApplicationController
  before_action :require_authentication
  before_action :require_transporter

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

  def require_transporter
    unless current_user&.transporter?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
