require 'rails_helper'

RSpec.describe "Api::V1::Customers DELETE /customers/:id", type: :request do
  let(:user) { create(:user) }
  let(:total_customers) {3}
  let(:customers) {create_list(:customer, total_customers)}
  let(:valid_customer_id) {customers.first.id}
  
  context 'user authenticated' do

    before{ user; customers } 

    context 'customer exist' do

      before {
        delete customer_path(valid_customer_id), headers: authorization_header(user)
      }

      it 'customer is deleted' do
        expect(Customer.count).to be(total_customers - 1)
        expect { Customer.find(valid_customer_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end 

      it 'status code' do
        expect(response).to have_http_status(:ok)
      end

    end

    context 'customer does not exist' do
      
      before {
        not_valid_id = Customer.order('id').last.try(:id).to_i + 1
        delete customer_path(not_valid_id), headers: authorization_header(user)
      }

      it 'status code' do
        expect(response).to have_http_status(:not_found)
      end

    end

    
  end

  context 'user not authenticated' do

    it 'DELETE /customer/:id' do
      delete customer_path(0)
      expect(response).to have_http_status(:unauthorized)
    end

  end

end