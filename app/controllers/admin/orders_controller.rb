class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def index
  end

  def show
    # 購入者 = 会員(姓) + (名)
    @customer_name = Customer.last_name + Customer.first_name
    # 注文IDに紐づく、OrderProductのデータを全件取得
    @order_products = OrderProduct.where(order_id: params[:id])
    # 商品合計 = 請求金額 - 送料
    @amaunt_ex_shipping = @order.request_amount - @order.shipping_fee
  end

  def update
    if params[:order][:order_status].to_i == 1         # 注文ステータス1：入金確認
      @order.update(order_status_params)
      @order_products.update(production_status: 1)     # 全商品の製作ステータス：1(=製作待ち)に変更
      redirect_to admin_order_path(@order)
    elsif params[:order][:order_status].to_i == 4      # 注文ステータス4：発送済み
      @order.update(order_status_params)
      redirect_to admin_order_path(@order)
    else
      @customer_name = Customer.last_name + Customer.first_name
      @order_products = OrderProduct.where(order_id: params[:id])
      @amaunt_ex_shipping = @order.request_amount - @order.shipping_fee
      render :show
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
