class User < ApplicationRecord
  has_secure_password


  validates :username, uniqueness: true
  validates :username, presence: true
  validates :email, presence: true
  
  belongs_to :role

  def as_json(*)
    super(except: [:password_digest, :uid, :role_id]).tap do |hash|
      hash[:role] = role.as_json
    end
  end

  def standard?
    role.name.eql? 'standard'
  end

  def admin?
    role.name.eql? 'admin'
  end

end


