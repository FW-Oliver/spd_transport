class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  rate_limit to: 10,
             within: 3.minutes,
             only: :create,
             with: -> {
               redirect_to new_session_path,
                          alert: "Try again later."
             }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path,
                  alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, status: :see_other
  end

  private

    def after_authentication_url
    case Current.user.role
    when "admin"
      root_path
    when "transporter"
      transporter_dashboard_path
    when "viewer"
      dashboard_path
    when "nurse"
      root_path
    else
      root_path
    end
  end
end