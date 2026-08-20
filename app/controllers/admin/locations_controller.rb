class Admin::LocationsController < ApplicationController
  before_action :require_authentication
  before_action :require_admin
  before_action :set_location, only: %i[edit update qr_poster]

  def index
    @locations = current_user.organization.locations.order(:name)
  end

  def new
    @location = current_user.organization.locations.new
  end

  def create
    @location = current_user.organization.locations.new(location_params)

    if @location.save
      redirect_to admin_locations_path, notice: "Location created successfully."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to admin_locations_path, notice: "Location updated successfully."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def qr_poster
    @qr_url = location_url(@location.qr_token)
    @qr_code = RQRCode::QRCode.new(@qr_url)
  end

private

  def set_location
    @location = current_user.organization.locations.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :active)
  end
end