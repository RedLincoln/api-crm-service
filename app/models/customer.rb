class Customer < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :surname, presence: true

  belongs_to :creator, class_name: 'User'
  belongs_to :modifier, class_name: 'User'
end
