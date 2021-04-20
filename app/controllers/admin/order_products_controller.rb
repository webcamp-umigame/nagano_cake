class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = Order.find(params[:order_id])
    if @order.order_status == 1
      @order_product.update(production_status: 1)
    else
      @order_product.update(order_products_params)
    end
  end

  private

  def order_products_params
    params.require(:order_product).permit(:production_status)
  end
end
