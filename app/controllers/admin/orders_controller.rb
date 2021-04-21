class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def index
  end

  def show
    # 購入者 = 会員(姓) + (名)
    @customer_name = Customer.last_name + Customer.first_name
    # 注文IDに紐づく、OrderProductのデータを全件取得
    @order_products = OrderProduct.where(order_id: params[:id])
    # 商品合計 = 請求金額 - 送料
    @amaunt_ex_shipping = @order.request_amount - @order.shipping_fee
  end

  def update
    if params[:order][:order_status].to_i == 1     #注文ステータス1：入金確認
      @order.update(order_status_params)
      @order_product.update(order_products_params: 1) #製作ステータス：1(=製作待ち)に変更
    elsif params[:order_product][:production_status].to_i == 3  #製作ステータス3：製作完了
      @order_product.update(order_products_params)

      # この注文の注文商品データをwhereで取得。pluckで製作テータスのみを配列にして、重複を削除してから個数を数える
      # 全部の商品の製作ステータスが同じだったら、個数は1になる（はず）
      if (OrderProduct.where(order_id: @order.id).pluck(:production_status).uniq.count == 1) && (@order_product.production_status == 3)
        @order.update(order_status: 3)
      end
    end

    # 製作中の商品が1件以上ある場合、注文ステータスを2 (=製作中) に更新
    if production_status_2 >= 1
      @order.update(order_status: 2)
      # 注文した全商品が制作完了した場合、注文ステータスを3 (=発送準備中) に更新
    elsif production_status_3.count == OrderProdurc.where(order_id: params[:id]).count
      @order.update(order_status: 3)
    else
      @order.update(order_status_params)
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_status_params
    params.require(:order).permit(:order_status)
  end
end
