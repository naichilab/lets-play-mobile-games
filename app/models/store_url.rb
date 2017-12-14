class StoreUrl < ApplicationRecord
  belongs_to :game
  belongs_to :platform

  validates :url, presence: true, length: {maximum: 256}
  validates :memo, length: {maximum: 256}
end
