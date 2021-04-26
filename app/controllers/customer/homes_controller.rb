class Customer::HomesController < ApplicationController

  def top
    @products = Product.where(sales_status: "販売中").order(created_at: :DESC)
  end
end
