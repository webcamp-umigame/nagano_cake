class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|

      t.integer :product_id,        null: false             #商品ID
      t.integer :order_id,          null: false             #注文ID
      t.integer :amount,            null: false             #注文商品の数量
      t.integer :tax_price,         null: false             #購入時税込価格
      t.integer :production_status, null: false, default: 0 #ステータス
      t.timestamps
    end
  end
end
