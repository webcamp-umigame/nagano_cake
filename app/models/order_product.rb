class OrderProduct < ApplicationRecord
  before_action :authenticate_admin!

  belongs_to :order
  belongs_to :product
end
