class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :email, presence: true
  validates :nickname, :gender, presence: true, on: :new
  validates :terms_of_service, acceptance: true, on: :new

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.last_name = auth.info.last_name
      user.first_name = auth.info.first_name
      user.image = auth.info.image
      user.gender = if auth.info.gender == 'male'
                   0
                 elsif auth.info.gender == 'female'
                   1
                 else
                   2
                 end

      user.password = Devise.friendly_token[0, 20]
      # user.image = auth.info.image # assuming the user model has an image
    end
  end
end
