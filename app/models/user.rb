class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:twitter]

  TEMP_EMAIL_PREFIX = 'change-me@'

  def self.new_token
    SecureRandom.urlsafe_base64
  end

end
