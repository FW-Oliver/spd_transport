class Admin::InformationPagesController < ApplicationController
  before_action :require_authentication
  before_action :require_admin
  before_action :set_information_page, only: %i[show edit update destroy]

  def index
    @information_pages = current_user.organization
                                      .information_pages
                                      .order(:title)
  end

  def show
  end

  def new
    @information_page = current_user.organization.information_pages.new
  end

  def create
    @information_page = current_user.organization
                                     .information_pages
                                     .new(information_page_params)

    if @information_page.save
      redirect_to admin_information_pages_path,
                  notice: "Information page created successfully."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @information_page.update(information_page_params)
      redirect_to admin_information_pages_path,
                  notice: "Information page updated successfully."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @information_page.destroy

    redirect_to admin_information_pages_path,
                notice: "Information page removed."
  end

  private

  def set_information_page
    @information_page = current_user.organization
                                      .information_pages
                                      .find(params[:id])
  end

  def information_page_params
    params.require(:information_page).permit(
      :title,
      :slug,
      :content,
      :published
    )
  end

  def toggle_publish
    @information_page.update!(
      published: !@information_page.published?
    )

    status = @information_page.published? ? "published" : "unpublished"

    redirect_to admin_information_page_path(@information_page),
                notice: "Information page #{status} successfully."
  end
end
