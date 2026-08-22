require "test_helper"

class Transporter::InformationController < ApplicationController
  before_action :require_authentication
  before_action :require_transporter

  def show
    @information_page = current_user.organization
                                      .information_pages
                                      .where(published: true)
                                      .find_by!(slug: params[:slug])
  end

  private

  def require_transporter
    unless current_user&.transporter?
      redirect_to root_path,
                  alert: "You have no valid access. Please try to select the correct role."
    end
  end
end