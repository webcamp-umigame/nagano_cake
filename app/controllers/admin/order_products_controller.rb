class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = Order.find(params[:order_id])
    if params[:order_product][:production_status].to_i == 2     #製作ステータス2：製作中
      @order_product.update(order_products_params)
      @order.update(order_status: 2)                             #注文ステータス：2(=製作中)に変更
    elsif params[:order_product][:production_status].to_i == 3  #製作ステータス3：製作完了
      @order_product.update(order_products_params)

      # この注文の注文商品データをwhereで取得。pluckで製作テータスのみを配列にして、重複を削除してから個数を数える
      # 全部の商品の製作ステータスが同じだったら、個数は1になる（はず）
      if (OrderProduct.where(order_id: @order.id).pluck(:production_status).uniq.count == 1) && (@order_product.production_status == 3)
        @order.update(order_status: 3)
      end
    end
  end

  private

  def order_products_params
    params.require(:order_product).permit(:production_status)
  end
end
