require 'rails_helper'

RSpec.describe "Api::V1::Customers PUT /customers/:id", type: :request do
  let(:user) { create(:user) }
  let(:customer_name) { 'old customer name' }
  let(:new_customer_name) { 'new customer name' }
  let(:customer) { create(:customer, name: customer_name) }
  
  context 'user authenticated' do

    before{ user; customer } 

    context 'customer exists' do

      before {
        put customer_path(customer.id), params: { name: new_customer_name }, headers: authorization_header(user)
      }

      it 'customer is updated' do
        expect(Customer.count).to be(1)
        expect(Customer.find(customer.id).name).to eq(new_customer_name)
        expect(Customer.find(customer.id).modifier_id).to eq(user.id)
        expect(json).to include('customer')
      end

      it 'status code' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'customer does not exists' do

      before {
        put customer_path(customer.id + 1), params: { name: new_customer_name }, headers: authorization_header(user)
      }

      it 'status code' do
        expect(response).to have_http_status(:not_found)
      end

    end
    
  end

  context 'user not authenticated' do

    it 'PUT /customer/:id' do
      put customer_path(0)
      expect(response).to have_http_status(:unauthorized)
    end

  end

end