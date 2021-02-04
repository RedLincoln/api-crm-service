require 'rails_helper'

RSpec.describe "Api::V1::Customers GET /customers", type: :request do
  let(:user) { create(:user) }
  let(:total_customers) {10}
  let(:customers) {create_list(:customer, total_customers)}
  let(:valid_customer_id) {customers.first.id}

  context 'user authenticated' do
  
    before{
      user
      user_authenticated(user.email)
    } 

    context 'initial state' do
      before { get customers_path, headers: { "Authorization" => "token"} }

      it 'no customers' do
        expect(json['customers']).to be_empty
      end
      
      it 'status code' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'customers stored' do
        
      before { customers; get customers_path, headers: { "Authorization" => "token"} }

      it 'return all customers' do
        expect(json['customers'].size).to be(total_customers)
      end

      it 'status code' do
        expect(response).to have_http_status(:ok)
      end
      
    end
  end

  context 'user not authenticated' do

    it 'GET /customers' do
      user_not_authenticated
      get customers_path
      expect(response).to have_http_status(:unauthorized)
    end

  end

end