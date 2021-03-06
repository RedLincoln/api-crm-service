require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { create(:customer)}

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:surname)}

    it 'attach valid image' do
      customer.photo.attach(
        io: File.open(Rails.root.join('spec', 'factories', 'img', 'face_test.jpg')),
        filename: 'face_test.jpg',
        content_type: 'image/jpeg'
      )

      expect(customer.photo).to be_attached
    end
  end

  describe 'associations' do
    it { should belong_to(:creator).class_name('User') } 
    it { should belong_to(:modifier).class_name('User') } 
  end

  describe 'defaut' do
    it 'have no photo attached' do
      expect(customer.photo).to_not be_attached
    end
  end

end