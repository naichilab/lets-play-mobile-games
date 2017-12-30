class StoreUrl < ApplicationRecord
  PERMIT_URL_REGEX=/\A#{URI::regexp(%w(http https))}\z/

  belongs_to :game
  belongs_to :platform

  validates :url, presence: true, length: {maximum: 256}, format: PERMIT_URL_REGEX
  validates :memo, length: {maximum: 256}
end
