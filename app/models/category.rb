class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 32}

  has_many :games
end
