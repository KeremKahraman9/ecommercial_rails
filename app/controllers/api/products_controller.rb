module Api
  class ProductsController < ApplicationController
    protect_from_forgery with: :null_session

    before_action :set_product, only: %i[update show destroy]
    after_action :after_action_method, only: %i[create]
    
    def index
      @products = Product.all
      if !@products.blank?
        @message = "Prodcuts rendered."
        render :index, status: :ok
      else
        @message = "Ürün yok"
        render :error, status: :bad_request
      end
    end

    def show
      # image = rails_blob_url(@product.product_image)
      render json: { "data": {product: @product,category: @product.category} }
    end

    def create
      @product = Product.create(product_params)
      if @product.valid?
        @product.save
        render json: :create, status: :ok
      else
        @message = @product.errors.full_messages
        render :error, status: :bad_request
      end
    end

    def update
      if @product.update (product_params)
        render :update, status: :ok
      else
        handler_error
      end
    end

    def destroy
      @product.destroy
      render json: "#{@product.id} id'li kayıt silindi"
    end

    private

    def handler_error
      render :error, status: :bad_request
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