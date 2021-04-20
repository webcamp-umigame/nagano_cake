class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
    @delivery = Delivery.new
    @delivers = current_customer.deliveries
  end

  def confirm
    @cart_items = current_customer.cart_items
		@order = Order.new
  end

  def create
    #@order = current_customer.order.new(order_params)
    #if @order.save
      redirect_to orders_thanx_path, flash: {success: "配送先を登録しました！"}
    #else
      @order = Order.all
      #render :index
    #end
  end

  def thanx
    @order = Order
  end

  def index
    @order = current_customer.orders
  end

  def show
    @order = Order
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_price)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def to_log
    redirect_to customers_cart_items_path if params[:id] == "log"
  end

end
