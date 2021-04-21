class Customer::CartItemsController < ApplicationController

  def index
    #current_customerのcart情報を全部取得
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
    @cart_item = CartItem.find_by(product_id: params[:id], customer_id: current_custmer.id)
    if @cart_item.present?
      @cart_item.amout += cart_item_params
      if @cart_item.save
        redirect_to action: :index
      else
        render "products/show/#{params[:product_id]}"
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