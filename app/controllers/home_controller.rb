class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    resume_session
  end

  def role
    resume_session

    case params[:role]
    when "admin"
      redirect_for_role(:admin, admin_dashboard_path)

    when "viewer"
      redirect_for_role(:viewer, dashboard_path)

    when "transporter"
      redirect_for_role(:transporter, transporter_dashboard_path)

    when "none"
      render :no_credentials

    else
      redirect_to root_path, alert: "Please select a valid role."
    end
  end

  private

  def redirect_for_role(role, destination)
    unless Current.user
      request_authentication
      return
    end

    if Current.user.public_send("#{role}?")
      redirect_to destination
    else
      flash[:role_error] =
        "Your account is an #{Current.user.role.capitalize} account. " \
        "The #{role.capitalize} role is not available for your user."

      redirect_to root_path
    end
  end
end
