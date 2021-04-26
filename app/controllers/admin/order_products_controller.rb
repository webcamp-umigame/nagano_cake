class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = Order.find_by(id: @order_product.order_id)
    if params[:order_product][:production_status] == "製作中"
      @order_product.update(order_product_params)
      @order_products = OrderProduct.where(order_id: @order.id)
      @order.update(order_status: "製作中")
    elsif params[:order_product][:production_status] == "製作完了"
      @order_product.update(order_product_params)
      @order_products = OrderProduct.where(order_id: @order.id)
      # 注文された商品の全データをwhereで取得。pluckで製作テータスのみを配列にして、重複を削除してから個数を数える
      # 全商品の製作ステータスが同じだったら、個数は1になる（はず）
      if OrderProduct.where(order_id: @order.id).pluck(:production_status).uniq.count == 1
        @order.update(order_status: "発送準備中")
      end
    else
      @order_products = OrderProduct.where(order_id: @order.id)
      @order_product = OrderProduct.find(params[:id])
      @order = Order.find_by(id: @order_product.order_id)
      # 商品合計 = 請求金額 - 送料
      @amaunt_ex_shipping = @order.request_amount - @order.shipping_fee
      render 'admin/orders/show'
    end
  end

  private

  def order_product_params
    params.require(:order_product).permit(:production_status)
  end

end
