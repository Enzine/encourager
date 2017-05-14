class Goal < ApplicationRecord

  validates :name, presence: true, allow_blank: false
  validates :score, numericality: {greater_than: 0, less_than: 11}

  has_many :user_goals, dependent: :destroy
  has_many :users, through: :user_goals

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
