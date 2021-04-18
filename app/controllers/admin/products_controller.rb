class Admin::ProductsController < ApplicationController

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
    if @product.save
      #　調べる
    redirect_to admin_products_path
  else
    @products = Product.all
    render :new
  end

  end

  # 商品編集
  def edit
    @product = Product.find(params[:id])
  end

  # 商品編集更新
  def update
  end



  #  ストロングパラメータ
  private

  def product_params
    params.require(:product).permit(:product_name, :product_image, :product_description, :sales_price, :sales_status, :genre_id)
  end


end
