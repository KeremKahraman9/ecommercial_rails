module Api
  class ProductsController < ApplicationController
    
    def index
      @products = Product.all
      render json: @products
    end

    def show
      @products = Product.find(params[:id])
      render json: @products
    end

    def create
      @product = Product.create(product_params)
      @product.save
      render json: @products
    end

    def update
      @product = Product.find(params[:id])
      @product = update(product_params)
      render json: @products
    end

    def product_params
      params.permit(:name, :description, :quantity, :price)
    end

  end
end