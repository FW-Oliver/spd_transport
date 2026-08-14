class ApplicationController < ActionController::Base
  include Authentication

  helper_method :current_user

  private

  def current_user
    Current.user
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end