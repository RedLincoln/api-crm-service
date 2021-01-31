class Customer < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :surname, presence: true

  belongs_to :creator_id, class_name: 'User', foreign_key: 'user_id'
  belongs_to :modifier_id, class_name: 'User', foreign_key: 'user_id'
end
