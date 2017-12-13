class Game < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: {maximum: 64}
  validates :guideline, length: {maximum: 512}

  mount_uploader :icon, IconUploader

  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  mount_uploader :image4, ImageUploader
  mount_uploader :image5, ImageUploader

end
