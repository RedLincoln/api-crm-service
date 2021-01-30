require 'rails_helper'

RSpec.describe "Api::V1::Customers GET /customers/:id", type: :request do
  let(:user) { create(:user) }
  let(:total_customers) {10}
  let(:customers) {create_list(:customer, total_customers)}
  let(:valid_customer_id) {customers.first.id}
  
  context 'user authenticated' do

    before{ user } 

    context 'initial state' do
      before { get customer_path(0), headers: authorization_header(user)}

      it 'status code' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'customers stored' do

      describe 'with valid customer id' do
        before { get customer_path(valid_customer_id), headers: authorization_header(user) }

        it 'content' do
          expect(json).to include('customer')
          expect(json['customer']['id']).to be(valid_customer_id)
        end
        
        it 'status code' do
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'without valid customer id' do
        before {
          not_valid_customer_id = customers.sort_by(&:id).last.try(:id).to_i + 1
          get customer_path(not_valid_customer_id), headers: authorization_header(user)
        }

        it 'status code' do
          expect(response).to have_http_status(:not_found)
        end

      end
    end
    
  end

  context 'user not authenticated' do

    it 'GET /customer/:id' do
      get customer_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
    
  end

end