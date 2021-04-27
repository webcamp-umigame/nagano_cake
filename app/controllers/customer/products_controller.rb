class Customer::ProductsController < ApplicationController
 
  def index
   @products_all = Product.where(sales_status: "販売中")
   @products = Product.where(sales_status: "販売中").page(params[:page]).per(8)
   @product = Product.page(params[:page]).per(8)
  end

  def show
   @product = Product.find(params[:id])
   @cart_item = CartItem.new
  end
  
  def search
   @products_all = Product.where(sales_status: "販売中")
   @products = Product.where(sales_status: "販売中").page(params[:page]).per(8)
   @product = Product.page(params[:page]).per(8)
  end
 private

  def product_params
   params.require(:product).permit(:product_name, :product_image, :product_description, :sales_price, :sales_status)
  end


end
