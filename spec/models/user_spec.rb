require 'rails_helper'

RSpec.describe User, type: :model do
  

  describe 'validations' do
    it { should validate_presence_of(:username)}
    it { create(:user); should validate_uniqueness_of(:username)}
  end

  describe 'assosiations' do
    it { should belong_to(:role) } 
  end
end
