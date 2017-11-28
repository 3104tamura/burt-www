# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :nickname, :gender, presence: true, on: :create

  def self.from_omniauth(auth)
    where(provider: 'facebook', uid: auth.uid).first_or_create do |user|
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
      # FIXME: 暫定
      user.nickname = 'facebook認証'

      user.password = Devise.friendly_token[0, 20]
    end
  end
end
