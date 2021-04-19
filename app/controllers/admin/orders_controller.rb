class Admin::OrdersController < ApplicationController
  before_action :set_order

  def show
    @customer_name = Customer.last_name + Customer.first_name
    # 注文IDに紐づく、OrderProductのデータを全件取得
    @order_products = OrderProduct.Where(order_id: params[:id])
  end

  def update
    @order_status = @order.order_status
    # @production_status = OrderProduct.find_by()
    if @order_status.save

    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
