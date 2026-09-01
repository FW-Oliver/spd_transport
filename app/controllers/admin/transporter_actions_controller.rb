class Admin::TransporterActionsController < ApplicationController
  before_action :require_authentication
  before_action :require_admin
  before_action :set_action, only: %i[edit update destroy]

  def index
    @actions = current_user.organization
                           .transporter_actions
                           .order(:position, :name)
  end

  def new
    @action = current_user.organization.transporter_actions.new
  end

  def create
    @action = current_user.organization.transporter_actions.new(action_params)

    if @action.save
      redirect_to admin_transporter_actions_path,
                  notice: "Transporter action created successfully."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @action.update(action_params)
      redirect_to admin_transporter_actions_path,
                  notice: "Transporter action updated successfully."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @action.destroy

    redirect_to admin_transporter_actions_path,
                notice: "Transporter action removed."
  end

  private

  def set_action
    @action = current_user.organization.transporter_actions.find(params[:id])
  end

  def action_params
    params.require(:transporter_action).permit(
      :name,
      :description,
      :requires_photo,
      :requires_acknowledgement,
      :acknowledgement_text,
      :active,
      :position
    )
  end
end
