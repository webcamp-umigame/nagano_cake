class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = Order.find_by(id: @order_product.order_id)
    if params[:production_status] == "製作待ち"
      redirect_to admin_order_path(@order)
    elsif params[:production_status] == "製作中"
      @order_product.update(production_status: params[:production_status])
      @order.update(order_status: "製作中")
      redirect_to admin_order_path(@order)
    elsif params[:production_status] == "製作完了"
      @order_product.update(production_status: params[:production_status])
      # 注文された商品の全データをwhereで取得。pluckで製作テータスのみを配列にして、重複を削除してから個数を数える
      # 全商品の製作ステータスが同じだったら、個数は1になる（はず）
      if OrderProduct.where(order_id: @order.id).pluck(:production_status).uniq.count == 1
        @order.update(order_status: "発送準備中")
        redirect_to admin_order_path(@order)
      else
        redirect_to admin_order_path(@order)
      end
    end
  end
end
