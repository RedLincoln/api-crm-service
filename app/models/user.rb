class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true
  validates :username, presence: true

  belongs_to :role

  def as_json(*)
    super(except: [:password_digest])
  end
end


