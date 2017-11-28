# frozen_string_literal: true

class Trainer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :cover, CoverUploader
  attr_accessor :category_ids

  has_many :category_trainers
  has_many :categories, through: :category_trainers

  validates :email, presence: true

  with_options on: :update_profile do |updatetion|
    updatetion.validates :name, presence: true
    updatetion.validates :age, inclusion: { in: [0, 1, 2, 3],
                                            message: 'を選択してください' }
    updatetion.validates :area, inclusion: { in: [0, 1, 2],
                                             message: 'を選択してください' }
    updatetion.validates :category_trainers, presence: true
    updatetion.validates :profile, presence: true
    updatetion.validates :comment_to_users, presence: true
    updatetion.validates :cover, presence: true, if: -> { image.blank? }
  end

  before_validation :set_category_trainers
  after_update :destroy_category_trainers

  def initialize(*args)
    @category_ids = []
    super
  end

  class << self
    def from_omniauth(auth)
      where(provider: 'facebook', uid: auth.uid).first_or_create do |trainer|
        trainer.email = auth.info.email
        trainer.last_name = auth.info.last_name
        trainer.first_name = auth.info.first_name
        trainer.image = auth.info.image
        trainer.gender = if auth.info.gender == 'male'
                           0
                         elsif auth.info.gender == 'female'
                           1
                         else
                           2
                   end
        # FIXME: 暫定
        trainer.nickname = 'facebook認証'
        trainer.password = Devise.friendly_token[0, 20]
      end
    end
  end

  def set_category_trainers
    return if category_ids.nil?
    registered_category_ids = category_trainers.map(&:category_id)
    @category_ids.uniq.each do |category_id|
      next if registered_category_ids.include?(category_id.to_i)
      category_trainers.build(category_id: category_id)
    end
  end

  def destroy_category_trainers
    category_trainers.each do |category_trainer|
      next if @category_ids.include?(category_trainer.category_id.to_s)
      category_trainer.destroy
    end
  end
end
