class Customer::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

 private
  def product_params
    params.require(:product).permit(:product_name, :product_image, :product_description, :sales_price, :sales_status)
  end


end
