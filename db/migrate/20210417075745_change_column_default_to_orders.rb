class ChangeColumnDefaultToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column_default :orders, :payment_method, from: nil, to: 0  #支払い方法
    change_column_default :orders, :order_status,   from: nil, to: 0  #受注ステータス
  end
end
