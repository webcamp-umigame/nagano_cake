class Admin::ProductsController < ApplicationController

  # 商品新規投稿
  def new
    @product = Product.new
  end

  # 投稿一覧
  def index
    @product = Products.all
  end

  # 商品詳細
  def show
    @product = Product.find(params[:id])
  end

  # 投稿データ保存
  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to product_path
  end




  #  ストロングパラメータ
  private

  def product_path
    params.require(:product).permit(:product_name, :product_image, :product_description, :sales_price, :sales_status)
  end


end
