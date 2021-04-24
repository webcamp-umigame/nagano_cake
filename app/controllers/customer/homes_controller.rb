class Customer::HomesController < ApplicationController

  def top
    @product = Product.limit(4).order(created_at: :DESC)
    @product = Product.limit(4).where(sales_status: "販売中")
  end
end
