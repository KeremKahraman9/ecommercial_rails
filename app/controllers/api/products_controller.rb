module Api
  class ProductsController < ApplicationController
    protect_from_forgery with: :null_session

    before_action :set_product, only: %i[update show destroy]
    after_action :after_action_method, only: %i[create]
    def index
      @products = Product.all
      render json: @products
    end

    def show
      image = rails_blob_url(@product.product_image)
      render json: { "image": image, "data": @product }
    end

    def create
      @product = Product.create(product_params)
      if @product.valid?
        @product.save
        render json: @products
      else
        render json: @product.errors.full_messages, status:400
      end
    end

    def update
      @product = update(product_params)
      render json: @products
    end

    def destroy
      @product.destroy
      render json: "#{@product.id} id'li kayıt silindi"
    end

    def set_product
      @product=Product.find(params["id"])
      print "set product before action methodu çalıştı"
    end

    def after_action_method
      p 'After action method proceed'
    end

    def product_params
      params.permit(:name, :description, :quantity, :price, :product_image)
    end

  end
end