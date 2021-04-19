class OrderProduct < ApplicationRecord
  before_action :authenticate_admin!

  belongs_to :order
  belongs_to :product

  # 製作ステータス（default: 0）
  enum production_status: {
    "着手不可": 0,
    "製作待ち": 1,
    "製作中": 2,
    "製作完了": 3,
  }
end
