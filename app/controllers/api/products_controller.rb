module Api
  class ProductsController < ApplicationController
    protect_from_forgery with: :null_session

    # before_action :set_product, only: %i[update show destroy]
    # after_action :after_action_method, only: %i[create]
    # before_action :authenticate_user!
    # before_action -> {check_user_roles(Security::RoleModule.only_admin_and_superadmin)}, only: %i[update create destroy]
    # before_action -> {check_user_roles(Security::RoleModule.all_roles)}
    before_action :read_cache, only: %i[index show]
    after_action -> {write_cache(@product)}, only: %i[index show], if: -> {@is_cached == false}
    after_action -> {remove_cache(index, show)}, only: %i[create update destroy]
    after_action :log_file

    def index
      @product = Product.mlamsdkm
      # authorize(@product)
      if !@product.blank?
        @message = "Prodcuts rendered."
        render :index, status: :ok
      else
        @message = "Ürün yok"
        handler_error
      end
    end

    # def show
    #   authorize(@product)
    #   # image = rails_blob_url(@product.product_image)
    #   render json: { "data": {product: @product,category: @product.category} }
    # end

    def show
      @product = Product.create(product_params)
      # authorize(@product)
      if !@product.blank?
        render :show, status: :ok
      else
        handler_error
      end
    end

    def create
      @product = Product.create(product_params)
      authorize(@product)
      if @product.valid?
        @product.save
        render :create, status: :ok
      else
        @message = @product.errors.full_messages
        handler_error
      end
    end

    def update
      authorize(@product)
      if @product.update (product_params)
        render :update, status: :ok
      else
        handler_error
      end
    end

    def destroy
      # authorize(@product)
      @product.destroy
      render json: "#{@product.id} id'li kayıt silindi"
    end

    private
    def handler_error
      render :error, status: :bad_request
      # render json: { message: @message }, status: :not_found
    end

    def set_product
      @product=Product.find(params["id"])
      print "set product before action methodu çalıştı"
    end

    def after_action_method
      p 'After action method proceed'
    end

    def product_params
      params.permit(:name, :description, :quantity, :price, :product_image, :category_id)
    end

  end
end