class Customer::CartItemsController < ApplicationController

  def index
    #current_customerのcart情報を全部取得
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
    # cart_itemの有無を確認、なければcart_itemを作る
    if session[:cart_item_id]
      @cart_item = CartItem.find(session[:cart_item_id])
    else
      @product = Product.find(params[:id])
      @cart_item = current_customer.cartItems.new(cart_item_params)
      @cart_item.product_id = @product.id
      if @cart_item.save
        session[:cart_item_id] = @cart_item.id
      else
        render "products/show/#{params[:product_id]}"
      end
    end
  end

  def update
  end

  def destroy
    @cart_item = CartItem.find(session[:cart_item_id])
    @cart_item.destroy
  end

  def destroy_all
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.destroy
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :customer_id, :amount)
  end

end