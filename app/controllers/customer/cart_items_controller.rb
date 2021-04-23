class Customer::CartItemsController < ApplicationController

  def index
    #current_customerのcart情報を全部取得
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
    @cart_item = CartItem.find_by(product_id: params[:product_id], customer_id: current_customer.id)
    # すでにその商品がカートに入っていたら、個数を追加
    if @cart_item.present?
      @cart_item.amount += params[:cart_item][:amount].to_i
      if @cart_item.amount > 9
        flash[:danger] = "各商品のご注文は9個までです。カート内にすでに商品がありますので、ご確認をお願いいたします。"
        render template: "customer/products/show"
      elsif @cart_item.save
        redirect_to cart_items_path, flash: {success: "商品の個数を追加しました"}
      else
        render template: "customer/products/show"
      end
    else
      # まだその商品がカートに入っていなかったらカートに追加
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.product_id = params[:product_id]
      if @cart_item.save
        redirect_to cart_items_path
      else
        # params.idわたってない？
        @product = Product.find(params[:product_id])
        render template: "customer/products/show"
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:success] = "商品の個数を更新しました"
      redirect_back(fallback_location: cart_items_path)
    else
      @cart_items = CartItem.where(customer_id: current_customer.id)
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, flash: {warning: "カートから商品を削除しました"}
  end

  def destroy_all
    #current_customerのcart情報を全部取得
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.destroy_all
    redirect_to cart_items_path, flash: {warning: "カート内の商品ををすべて削除しました"}
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

end