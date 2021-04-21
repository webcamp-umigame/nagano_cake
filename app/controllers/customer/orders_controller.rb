class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
    @delivery = Delivery.new
    @delivers = current_customer.deliveries
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
    @order = current_customer.orders.new(order_params)
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.addressee = current_customer.first_name+current_customer.last_name

    elsif  params[:order][:address_number] ==  "2"
      @order.address = params[:address]

    elsif params[:order][:address_number] ==  "3"
      @delivery = current_customer.deliveries.new(address_params)
      if @delivery.save
        @order.postal_code = @delivery.postal_code
        @order.addressee = @delivery.addressee
        @order.address = @delivery.address
      else
        render 'new'
      end
    end
  end

  def create

    @order.request_amount = 10000
    @order.save
    @cart_items = CartItem.where(customer_id: current_customer.id)

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
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :addressee, :payment_method, :request_amount)
  end

  def address_params
    params.require(:deliveries).permit(:postal_code, :address, :addressee)
  end

end
