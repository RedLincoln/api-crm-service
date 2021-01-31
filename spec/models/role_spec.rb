require 'rails_helper'

RSpec.describe Role, type: :model do
  
  describe 'validations' do

    it { should validate_presence_of(:name) }
    it { create(:role); should validate_uniqueness_of(:name) }
  end

end
