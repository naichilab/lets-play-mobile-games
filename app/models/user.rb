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

  def update_password_only(params, *options)
    current_password = params.delete(:current_password)
    result = if valid_password?(current_password) && params[:password].present?
                update_attributes(params, *options)
             else
               self.assign_attributes(params, *options)
               self.valid?
               self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
               false
             end

    clean_up_passwords
    result
  end
end
