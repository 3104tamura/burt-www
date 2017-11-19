class Category < ApplicationRecord
  has_many :category_trainers
  has_many :trainers, through: :category_trainers
end
