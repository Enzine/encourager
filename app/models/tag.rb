class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :goals, through: :taggings
end
