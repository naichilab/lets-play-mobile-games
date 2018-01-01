class Tag < ApplicationRecord
  belongs_to :game
  validates :name, presence: true, length: {maximum: 8}
end
