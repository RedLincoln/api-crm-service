class Role < ApplicationRecord

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.default_role_params
    { name: 'standard', description: 'The user can manage customers' }
  end

  def self.get_role_by_name(name=Role.default_role_params[:name])
    if Role.exists?(name: name)
      Role.find_by(name: name)
    else
      unless Role.exists?(name: Role.default_role_params[:name])
        Role.create(Role.default_role_params)
      end
      Role.find_by(name: Role.default_role_params[:name])
    end
  end
  
end
