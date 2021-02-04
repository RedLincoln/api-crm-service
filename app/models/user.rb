class User < ApplicationRecord
  has_secure_password
  #before_create :create_auth0_user
  #after_destroy :destroy_auth0_user
  #after_update :update_auth0_user


  validates :username, uniqueness: true
  validates :username, presence: true
  validates :email, presence: true
  
  belongs_to :role

  def as_json(*)
    super(except: [:password_digest]).tap do |hash|
      hash[:role] = role.as_json
    end
  end

  def standard?
    role.name.eql? 'standard'
  end

  def admin?
    role.name.eql? 'admin'
  end

  private

  def update_auth0_user
    AuthApiManagment.update_user(self.id, {
        username: self.username,
        email: self.email,
        password: self.password_digest
      })
  end
  
  def create_auth0_user
    user_id = AuthApiManagment.create_user(self)[:user_id]
    throw :abort unless user_id
    self.uid = user_id
  end

  def destroy_auth0_user
    AuthApiManagment.delete_user(self)
  end

end


