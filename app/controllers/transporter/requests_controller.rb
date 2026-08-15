class Transporter::RequestsController < ApplicationController
  before_action :require_transporter
  before_action :set_request

  def accept
    @request.update!(
      status: "accepted",
      accepted_by: Current.user,
      accepted_at: Time.current
    )

    redirect_to transporter_dashboard_path,
      notice: "Transport request accepted."
  end

  def start_transport
  @request.update!(
    status: "in_transit",
    in_transit_by: Current.user,
    in_transit_at: Time.current
  )

  redirect_to transporter_dashboard_path,
    notice: "Transport is now in transit."
  end

  def complete
  request = current_user.organization.transport_requests.find(params[:id])

  unless request.status == "in_transit"
    redirect_to transporter_dashboard_path,
                alert: "This transport cannot be completed yet."
    return
  end

  request.update!(
    status: "completed",
    completed_by: current_user,
    completed_at: Time.current
  )

  redirect_to transporter_dashboard_path,
              notice: "Transport completed successfully."
  end

  private

  def set_request
    @request = Current.user.organization.transport_requests.find(params[:id])
  end

  def require_transporter
    unless Current.user&.transporter?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end

