require 'rails_helper'
require 'cancan/matchers'

RSpec.describe 'Customer ability' do
  let(:admin) { create(:user, role: create(:role, name: 'admin'))}
  let(:user) { create(:user, role: create(:role, name: 'standard'))}

  describe 'admin user' do
    let( :ability ) { CustomerAbility.new(admin) }

    it { expect(ability).to be_able_to(:manage, Customer) }
  end

  describe 'standard role' do
    let(:ability) { CustomerAbility.new(user)}

    it { expect(ability).to be_able_to(:manage, Customer)}
  end
  

end