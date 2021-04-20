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
      @cart_item = current_customer.CartItems.new(cart_item_params)
      @cart_item.product_id = @product.id
      if @cart_item.save
        session[:cart_item_id] = @cart_item.id
        redirect_to cart_items_path
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.product_id = params[:product_id]
      if @cart_item.save
        session[:cart_item_id] = @cart_item.id
        redirect_to action: :index
      else
        render "products/show/#{params[:product_id]}"
      end
      end
    end
  end

  def update
  end

  def destroy
    reset_session
    @cart_item = CartItem.find(session[:cart_item_id])
    @cart_item.destroy
    redirect_to action: :index
  end

  def destroy_all
    reset_session
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.destroy
    redirect_to action: :index
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

end