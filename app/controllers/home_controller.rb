class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
  end

  def role
    case params[:role]
    when "admin"
      redirect_for_role(:admin, root_path)
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
      redirect_to new_session_path,
                  alert: "Please log in before selecting this role."
      return
    end

    if Current.user.public_send("#{role}?")
      redirect_to destination
    else
      redirect_to root_path,
                  alert: "You have no valid access. Please try to select the correct role."
    end
  end
end
