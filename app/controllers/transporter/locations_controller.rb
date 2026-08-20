class Transporter::LocationsController < ApplicationController
  before_action :require_authentication
  before_action :require_transporter
  before_action :set_location

  def show
    @actions = current_user.organization
                             .transporter_actions
                             .where(active: true)
                             .order(:position, :name)
  end

  private

  def set_location
    @location = current_user.organization
                           .locations
                           .active
                           .find(params[:id])
  end

  def require_transporter
    unless current_user&.transporter?
      redirect_to root_path,
                  alert: "You are not authorized to access this page."
    end
  end
end