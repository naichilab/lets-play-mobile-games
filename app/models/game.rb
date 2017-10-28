class Game < ApplicationRecord
  mount_uploader :icon, IconUploader
  belongs_to :user, dependent: :destroy
  has_one :category
end
