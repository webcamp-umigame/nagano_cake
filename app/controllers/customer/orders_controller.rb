class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
    @delivery = Delivery.new
    @delivers = current_customer.deliveries
    # @customer_new = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    @order.address = params[:order][:address]
    if params[:order][:address_number] == "1"
      @order.postal_core = current_customer.postal_code
      @order.address = current_customer.address
      @order.addressee = current_customer.first_name+current_customer.last_name

    elsif  params[:order][:address_number] ==  "2"
      @order.address = params[:address]

    elsif params[:order][:address_number] ==  "3"
      @delivery = Delivery.new
      @delivery.address = params[:order][:address]
      @delivery.addressee = params[:order][:addressee]
      @delivery.postal_code = params[:order][:postal_core]
      @delivery.customer_id = current_customer.id
      if @delivery.save
        @order.postal_core = @delivery.postal_code
        @order.addressee = @delivery.addressee
        @order.address = @delivery.address
      else
        render 'new'
      end
    end
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def create
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.save

  current_customer.cart_items.each do |cart_item|
    @order_item = OrderProduct.new
    @order_item.product_id = cart_item.product_id
    @order_item.amount = cart_item.amount
    @order_item.tax_price = (cart_item.product.sales_price*1.1).floor
    @order_item.order_id = @order.id
    @order_item.save
  end

  current_customer.cart_items.destroy_all
  redirect_to orders_thanx_path

  end

  def thanx
    @order = Order
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order
  end

  private

  def order_params
    params.require(:order).permit(:postal_core, :address, :addressee, :payment_method, :request_amount, :address_number)
  end

  def address_params
   params.require(:deliveries).permit(:postal_code, :address, :addressee)
  end

end
