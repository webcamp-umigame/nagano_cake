class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :customer_id,	   null: false                #会員ID
      t.integer :payment_method, null: false                #支払い方法
      t.integer :shipping_fee,   null: false, default: 800  #送料
      t.integer :request_amount, null: false                #請求額
      t.integer :order_status,   null: false                #受注ステータス
      t.string :addressee,       null: false                #配送先氏名
      t.string :postal_core,     null: false                #配送先郵便番号
      t.string :address,         null: false                #配送先住所
      t.timestamps
    end
  end
end
