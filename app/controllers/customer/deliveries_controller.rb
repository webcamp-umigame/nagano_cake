class Customer::DeliveriesController < ApplicationController

  before_action :set_shipping_info, only: [:edit, :update, :destroy]

  # 配送先登録/一覧画面
  def index
    @delivery = current_customer.deliveries.new
    @deliveries = Delivery.all
  end

  # 配送先登録/一覧画面 => 配送先登録（注文情報入力画面の配送先登録は、orders controllerにて指定）
  def create
    @delivery = current_customer.deliveries.new(delivery_params)
    unless @delivery.save
      render 'error_messages'
    end
  end

  # 配送先編集画面
  def edit
  end

  # 配送先編集画面 => 配送先更新
  def update
    if @delivery.update(delivery_params)
      redirect_to deliveries_path, flash: {success: "配送先を更新しました！"}
    else
      render 'error_messages'
    end
  end

  # 配送先登録/一覧画面 => 配送先削除
  def destroy
    @delivery.destroy
  end

  private

  def set_shipping_info
    @delivery = Delivery.find(params[:id])
  end

  def delivery_params
    params.require(:delivery).permit(:addressee, :postal_code, :address)
  end
end
