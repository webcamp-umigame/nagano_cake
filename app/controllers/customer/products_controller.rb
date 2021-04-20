class Customer::ProductsController < ApplicationController

  def index
   @products = Product.where(sales_status: "販売中")
   @product = Product.page(params[:page]).per(8)
  end

  def show
   @product = Product.find(params[:id])
  end

 private

  def product_params
   params.require(:product).permit(:product_name, :product_image, :product_description, :sales_price, :sales_status)
  end


end
