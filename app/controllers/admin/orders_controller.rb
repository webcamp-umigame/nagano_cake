class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def order
    @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
  end

  def show
    # 注文IDに紐づく、OrderProductのデータを全件取得
    @order_products = OrderProduct.where(order_id: params[:id])
    # 商品合計 = 請求金額 - 送料
    @amaunt_ex_shipping = @order.request_amount - @order.shipping_fee
  end

  def update
    @order_products = OrderProduct.where(order_id: params[:id])
    if params[:order][:order_status] == "入金待ち"
      @order.update(order_status_params)
      @order_products.update(production_status: "着手不可")
    elsif params[:order][:order_status] == "入金確認"
      @order.update(order_status_params)
      @order_products.update(production_status: "製作待ち")
    elsif params[:order][:order_status] == "発送済み"
      @order.update(order_status_params)
    elsif
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
