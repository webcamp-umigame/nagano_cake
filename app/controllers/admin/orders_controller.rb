class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order

  def show
    # 購入者 = 会員(姓) + (名)
    @customer_name = Customer.last_name + Customer.first_name
    # 注文IDに紐づく、OrderProductのデータを全件取得
    @order_products = OrderProduct.where(order_id: params[:id])
    # 商品合計 = 請求金額 - 送料
    @amaunt_ex_shipping = @order.request_amount - @order.shipping_fee
  end

  def update
    # 注文された商品の製作ステータス: "製作中" = 2   であるデータを全件取得
    production_status_2 = OrderProduct.where(order_id: params[:id]).where(production_status: 2)
    # 注文された商品の製作ステータス: "製作完了" = 3 であるデータを全件取得
    production_status_3 = OrderProduct.where(order_id: params[:id]).where(production_status: 3)

    # 製作中の商品が1件以上ある場合、注文ステータスを2 (=製作中) に更新
    if production_status_2 >= 1
      @order.update(order_status: 2)
      # 注文した全商品が制作完了した場合、注文ステータスを3 (=発送準備中) に更新
    elsif production_status_3.count == OrderProdurc.where(order_id: params[:id]).count
      @order.update(order_status: 3)
    else
      @order.update(order_status_params)
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_status_params
    params.require(:order).permit(:order_status)
  end
end
