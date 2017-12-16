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

  scope :has_android, -> do
    is_not_null = Game.arel_table[:android_url].not_eq(nil)
    is_not_blank = Game.arel_table[:android_url].not_eq('')
    where(is_not_null).where(is_not_blank)
  end

  scope :has_ios, -> do
    is_not_null = Game.arel_table[:ios_url].not_eq(nil)
    is_not_blank = Game.arel_table[:ios_url].not_eq('')
    where(is_not_null).where(is_not_blank)
  end



end
