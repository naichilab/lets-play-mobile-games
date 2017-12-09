class User < ApplicationRecord
  TEMP_EMAIL_PREFIX = 'change-me@'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:twitter]

  # validates
  validates :username, presence: true, length: {maximum: 50}

  # relations
  has_many :games, dependent: :destroy


  def self.new_token
    SecureRandom.urlsafe_base64
  end

end
