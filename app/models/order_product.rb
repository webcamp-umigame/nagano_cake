class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # 製作ステータス（default: 0）
  enum production_status: {
    "着手不可": 0,
    "製作待ち": 1,
    "製作中": 2,
    "制作完了": 3,
  }
end
