class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!    
  # 商品新規投稿
  def new
    @product = Product.new
  end

  # 投稿一覧
  def index
    @products = Product.all
    @product = Product.new
  end

  # 商品詳細
  def show
    @product = Product.find(params[:id])
  end

  # 投稿データ保存
  def create
    @product = Product.new(product_params)
    @product.save
      #　調べる
    redirect_to admin_products_path
  end

  # 商品編集
  def edit
    @product = Product.find(params[:id])
  end

  # 商品編集更新
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to admin_products_path
  end



  #  ストロングパラメータ
  private

  def product_params
    params.require(:product).permit(:product_name, :product_image, :product_description, :sales_price, :sales_status, :genre_id)
  end


end
