class Customer < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :surname, presence: true
end
