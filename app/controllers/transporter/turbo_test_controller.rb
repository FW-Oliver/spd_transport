class Transporter::TurboTestController < ApplicationController
  before_action :require_authentication
  before_action :require_transporter

  def show
  end

  def send_test
    Turbo::StreamsChannel.broadcast_update_to(
      "turbo_test",
      target: "turbo-test-message",
      html: "<strong>🎉 Turbo received this!</strong>"
    )

    redirect_to transporter_turbo_test_path
  end

  private

  def require_transporter
    unless current_user&.transporter?
      redirect_to root_path,
                  alert: "You are not authorized to access this page."
    end
  end
end
