require 'rails_helper'

RSpec.describe "Api::V1::Customers GET /customers", type: :request do
  let(:user) { create(:user) }
  
  context 'user authenticated' do

    before{ user } 

    context 'create customer with valid fields' do
      let(:customer_name) { 'name '}
      let(:customer_surname) { 'surname' }
      before {
        photo = Rack::Test::UploadedFile.new(
          File.open(Rails.root.join('spec', 'factories', 'img', 'face_test.jpg')))
        post customers_path,
          params: {name: customer_name, surname: customer_surname, photo: photo},
          headers: authorization_header(user)
      }

      it '' do 
        expect(Customer.count).to eq(1)

        expect(Customer.first.name).to eq(customer_name)
        expect(Customer.first.surname).to eq(customer_surname)
        expect(Customer.first.photo).to be_attached
        expect(Customer.first.creator_id).to eq(user.id)
        expect(Customer.first.modifier_id).to eq(user.id)
      end

      it 'status code' do
        expect(response).to have_http_status(:created)
      end
    end
    
    context 'create customer with bad params' do
      before {
        post customers_path, headers: authorization_header(user)
      }

      it '' do
        expect(Customer.count).to be(0)
      end

      it 'status code' do
        expect(response).to have_http_status(:bad_request)
      end

    end

    
  end

  context 'user not authenticated' do

    it 'POST /customers' do
      post customers_path
      expect(response).to have_http_status(:unauthorized)
    end

  end

end