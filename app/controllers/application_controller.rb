class ApplicationController < ActionController::Base
  include Authentication

  helper_method :current_user
  helper_method :organization_timezone
  helper_method :organization_time
  helper_method :organization_today

  private

  def current_user
    Current.user
  end

  def require_admin
    unless current_user&.admin?
      redirect_to new_session_path,
                  alert: "You are not authorized to access this page."
    end
  end

  def require_transporter
    unless current_user&.transporter?
      redirect_to new_session_path,
                  alert: "You are not authorized to access this page."
    end
  end

  def organization_timezone
    preference = current_user&.organization&.timezone_preference

    if preference.present? && preference != "auto"
      preference
    else
      Time.zone.name
    end
  end

  def organization_time(time)
    time&.in_time_zone(organization_timezone)
  end

  def organization_today
    Time.current.in_time_zone(organization_timezone).to_date
  end
end