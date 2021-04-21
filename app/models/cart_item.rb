class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  validates :amount, presence: true

  def add_tax_sales_price
   (self.sales_price * 1.10).round
  end

end
