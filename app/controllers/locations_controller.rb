class LocationsController < ApplicationController
  before_action :load_location

  def show
    @requests = @location.transport_requests
                          .order(created_at: :desc)

    @has_active_requests = @requests.active.exists?
  end

  def request_transport
    @location.transport_requests.create!(
      organization: @location.organization,
      status: "requested",
      requested_by_name: params[:requested_by_name],
      requested_at: Time.current
    )

    redirect_to location_path(@location.qr_token),
                notice: "Transport request sent successfully."
  end

  def cancel_request
    request = @location.transport_requests.find(params[:request_id])

    if request.cancellable?
      request.update!(
        status: "cancelled",
        cancelled_at: Time.current
      )

      redirect_to location_path(@location.qr_token),
                  notice: "Transport request cancelled."
    else
      redirect_to location_path(@location.qr_token),
                  alert: "This request can no longer be cancelled."
    end
  end

  private

  def load_location
    @location = Location.find_by!(qr_token: params[:qr_token])

    unless @location.active?
      render plain: "This location is currently inactive.", status: :not_found
    end
  end
end