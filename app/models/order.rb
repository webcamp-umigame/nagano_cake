class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products

   validates :customer, :address,:addressee, :shipping_fee,
   		  		:request_amount, :payment_method,
   		  		presence: true
   validates :postal_code, length: {is: 7}, format: { with: /\A\d{7}\z/}
  # validates :shipping_fee, :request_amount, format: { }
   attr_accessor :address_number
  
  enum payment_method: {
    "クレジットカード": 0,
    "銀行振込": 1,
  }
  # 注文ステータス（default: 0）
  enum order_status: {
    "入金待ち": 0,
    "入金確認": 1,
    "製作中": 2,
    "発送準備中": 3,
    "発送済み": 4,
  }
end
