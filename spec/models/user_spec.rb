require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, role: create(:role, name: 'standard'))}

  describe 'validations' do
    it { should validate_presence_of(:username)}
    it { user; should validate_uniqueness_of(:username)}
  end

  describe 'assosiations' do
    it { should belong_to(:role) } 
  end

end
