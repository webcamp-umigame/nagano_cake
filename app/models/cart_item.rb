class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  #validates :amount, numericality: { in: 1..9 }
  validates_inclusion_of :amount, presence: true, in:1..9

  # 税込み商品価格
  def tax_sales_price
    tax = 1.10
    ((self.product.sales_price * tax).round(2)).round
  end

end
