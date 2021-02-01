require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:admin_role) { create(:role, name: 'admin')}


  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { create(:role); should validate_uniqueness_of(:name) }
  end

  describe 'get role by name' do

    before {
      admin_role
    }

    it 'default role is standard' do
      role = Role.get_role_by_name
      expect(role.name).to eq(Role.default_role_params[:name])
    end

    it 'not valid role name returns default role' do
      role = Role.get_role_by_name('not_valid_role')
      expect(role.name).to eq(Role.default_role_params[:name])
    end

    it 'valid role name return the role' do
      role = Role.get_role_by_name(admin_role.name)
      expect(role.name).to eq(admin_role.name)
    end
  end

end
