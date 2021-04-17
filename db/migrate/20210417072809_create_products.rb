class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id,        	null: false                #ジャンルID
      t.string  :product_name,	    null: false                #商品名
      t.text  :product_description,	null: false                #商品説明文
      t.string  :product_image_id,	null: false                #商品画像id
      t.integer :sales_price,	      null: false                #販売価格(税抜き)
      t.boolean :sales_status,	    null: false, default: true #販売ステータス
      t.timestamps
    end
  end
end
