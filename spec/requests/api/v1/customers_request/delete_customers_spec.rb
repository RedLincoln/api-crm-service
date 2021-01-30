require 'rails_helper'

RSpec.describe "Api::V1::Customers GET /customers", type: :request do
  let(:user) { create(:user) }
  let(:total_customers) {10}
  let(:customers) {create_list(:customer, total_customers)}
  let(:valid_customer_id) {customers.first.id}
  
  context 'user authenticated' do

    before{ user } 

    context 'initial state' do

    end

    context 'customers stored' do

    end
    
  end

  context 'user not authenticated' do

    it 'DELETE /customer/:id' do
      delete customer_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
    
  end

end