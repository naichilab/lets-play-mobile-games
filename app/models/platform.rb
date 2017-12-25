class Platform < ApplicationRecord
  has_many :store_urls

  validates :code, presence: true, length: {maximum: 16}
  validates :name, presence: true, length: {maximum: 32}
end