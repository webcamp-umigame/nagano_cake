class Product < ApplicationRecord
  validates :product_name, presence:true
  validates :product_description, presence:true
  validates :sales_price, numericality: { only_integer: true }
  validates :sales_status, inclusion: { in: [true, false]}
  validates :genre, presence:true

  attachment :product_image

  belongs_to :genre
  has_many :cart_items
  has_many :order_products

  def add_tax_sales_price
    (self.sales_price * 1.10).round
  end

end
