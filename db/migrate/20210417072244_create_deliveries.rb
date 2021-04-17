class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.integer :customer_id, null: false #会員ID
      t.string :addressee,    null: false #宛名
      t.string :postal_code,  null: false #配送先郵便番号
      t.string :address,      null: false #配送先住所
      t.timestamps
    end
  end
end
