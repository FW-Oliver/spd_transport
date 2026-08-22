class Transporter::InformationController < ApplicationController
  before_action :require_authentication
  before_action :require_transporter

  def index
  end

  def rules
  end

  def access
  end

  def routes
  end

  private

  def require_transporter
    unless current_user&.transporter?
      redirect_to root_path,
                  alert: "You have no valid access. Please try to select the correct role."
    end
  end
end