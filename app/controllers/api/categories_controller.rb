module Api
  class CategoriesController < ApplicationController
    protect_from_forgery with: :null_session

    before_action :set_category, only: %i[update show destroy]
    before_action :authenticate_user!
    before_action -> {check_user_roles(Security::RoleModule.only_admin_and_superadmin)}, only: %i[update create destroy]

    def index
      @categories = Category.order(created_at: :desc)
      if !@categories.blank?
        render json: @categories, status: :ok
      else
        render json: @categories, status: :bad_request
      end
    end

    def show
      if !@category.blank?
        render json: @category, status: :ok
      else
        render json: @category, status: :bad_request
      end
    end

    def create
      @category = Category.create(params_category)
      byebug
      if @category.save
        render json: @category, status: :ok
      else
        render json: "Create Failed", status: :bad_request
      end
    end

    def update
      byebug
      if @category.update(params_category)
        render json: @category, status: :ok
      else
        render json: "Update Failed", status: :bad_request
      end
    end

    def destroy
      if @category.destroy
        render json: "Delete Success", status: :ok
      else
        render json: "Delete Failed", status: :bad_request
      end
    end
    
    private

    def set_category
      @category = Category.find(params[:id])
    end

    def params_category
      params.permit(:name)
    end

  end
end