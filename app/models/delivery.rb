class Delivery < ApplicationRecord
  belongs_to :customer

  validates :addressee, presence: true
  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }
  validates :address, presence: true

  def full_address
    postal_code + address + addressee
  end
end
