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

    elsif params[:order][:address_number] ==  "2"
      @delivery = Delivery.find(params[:order][:delivery_id])
      @order.postal_code = @delivery.postal_code
      @order.addressee = @delivery.addressee
      @order.address = @delivery.address

    elsif params[:order][:address_number] ==  "3"
      @order = current_customer.orders.new(order_params)
        @delivery = current_customer.deliveries.new
        @delivery.postal_code = @order.postal_code
        @delivery.addressee = @order.addressee
        @delivery.address = @order.address
        @delivery.save
      @order.save
    end
  end

  def create
    @cart_items = CartItem.where(customer_id: current_customer.id)
    request_amount = 0
    @cart_items.each do |cart_item|
      request_amount += (cart_item.amount * (((cart_item.product.sales_price * 1.10).round(2)).round))
    end
    @order = current_customer.orders.new(order_params)
    @order.request_amount = request_amount + @order.shipping_fee
    @order.save

    @cart_items.each do |cart_item|
      @order_item = OrderProduct.new
      @order_item = OrderProduct.create(product_id: cart_item.product_id, order_id: @order.id, amount: cart_item.amount, tax_price: ((cart_item.product.sales_price*1.10).round(2)).round)
    end

    if OrderProduct.where(order_id: @order.id).count == current_customer.cart_items.count
      current_customer.cart_items.destroy_all
      redirect_to orders_thanx_path
    end
  end

  def thanx
    @order = Order
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :addressee, :payment_method, :request_amount)
  end

  def delivery_params
    params.require(:delivery).permit(:postal_code, :address, :addressee)
  end

end
