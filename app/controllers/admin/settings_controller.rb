class Admin::SettingsController < ApplicationController
  before_action :require_authentication
  before_action :require_admin

  TIMEZONE_OPTIONS = [
    ["Auto — Detect from organization location", "auto"],
    ["Eastern Time (US & Canada)", "America/New_York"],
    ["Central Time (US & Canada)", "America/Chicago"],
    ["Mountain Time (US & Canada)", "America/Denver"],
    ["Pacific Time (US & Canada)", "America/Los_Angeles"],
    ["Alaska Time", "America/Anchorage"],
    ["Hawaii Time", "Pacific/Honolulu"]
  ].freeze

  def edit
    @organization = current_user.organization
  end

  def update
    @organization = current_user.organization

    if @organization.update(settings_params)
      redirect_to admin_dashboard_path, notice: "Organization settings updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def settings_params
    params.require(:organization).permit(:timezone_preference)
  end
end
