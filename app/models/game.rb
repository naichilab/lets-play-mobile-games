class Game < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :store_urls
  has_many :platforms, through: :store_urls

  validates :title, presence: true, length: {maximum: 64}
  validates :guideline, length: {maximum: 512}

  mount_uploader :icon, IconUploader

  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  mount_uploader :image4, ImageUploader
  mount_uploader :image5, ImageUploader

  scope :platform, ->(code) do
    platforms = Platform.arel_table
    store_urls = StoreUrl.arel_table

    target_platform = platforms
                          .project(platforms[:id])
                          .where(platforms[:code].eq(code))

    has_platform_store_urls = store_urls
                                  .project(store_urls[:game_id])
                                  .where(store_urls[:platform_id].eq(target_platform))

    where(Game.arel_table[:id].in(has_platform_store_urls))
  end

  def has_platform(code)

    self.platforms.any? do |p|
      p.code == code
    end
  end


end
