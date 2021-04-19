class Delivery < ApplicationRecord
  belongs_to :customer

  validates :addressee, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true
end
