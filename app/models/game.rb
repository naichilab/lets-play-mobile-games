class Game < ApplicationRecord
  mount_uploader :icon, IconUploader
  belongs_to :user
  has_one :category

  validates :title, presence: true, length: {maximum: 64}

end
