class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = Order.find(params[:order_id])
    if params[:order_product][:production_status].to_i == 1     #製作ステータス1：製作待ち
      redirect_to admin_order_path(@order)
    elsif params[:order_product][:production_status].to_i == 2  #製作ステータス2：製作中
      @order_product.update(order_products_params)
      @order.update(order_status: 2)                            #注文ステータス：2(=製作中)に変更
      redirect_to admin_order_path(@order)
    elsif params[:order_product][:production_status].to_i == 3  #製作ステータス3：製作完了
      @order_product.update(order_products_params)
      # 注文された商品の全データをwhereで取得。pluckで製作テータスのみを配列にして、重複を削除してから個数を数える
      # 全商品の製作ステータスが同じだったら、個数は1になる（はず）
      if OrderProduct.where(order_id: @order.id).pluck(:production_status).uniq.count == 1
        @order.update(order_status: 3)                          #注文ステータス：3(=製作完了)に変更
        redirect_to admin_order_path(@order)
      else
        redirect_to admin_order_path(@order)
      end
    end
  end

  private

  def order_products_params
    params.require(:order_product).permit(:production_status)
  end
end
