class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_products
end
