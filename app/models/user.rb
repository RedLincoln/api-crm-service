class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true

  def as_json(*)
    super(except: [:password_digest])
  end
end
