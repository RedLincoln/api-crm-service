require 'rails_helper'
require 'cancan/matchers'

RSpec.describe 'User ability' do
  let(:admin) { create(:user, role: create(:role, name: 'admin'))}
  let(:user) { create(:user, role: create(:role, name: 'standard'))}

  describe 'admin user' do
    let( :ability ) { UserAbility.new(admin) }

    it { expect(ability).to be_able_to(:manage, User) }
  end

  describe 'standard role' do
    let(:ability) { UserAbility.new(user)}

    it { expect(ability).to_not be_able_to(:manage, User)}
  end
  

end