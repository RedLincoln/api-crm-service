require 'rails_helper'

RSpec.describe "Api::V1::Customers", type: :request do

  describe 'initial state' do

    context 'GET /customers' do
      before { get customers_path }

      it 'no customers' do
        expect(json['customers']).to be_empty
      end
      
      it 'status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'GET /customers/:id' do
      before { get customer_path(0)}

      it 'status code' do
        expect(response).to have_http_status(404)
      end
    end
    
  end

  describe 'with customers stored' do
    let(:customers) {create_list(:customer, 10)}

    context 'GET /customers' do
      before {
        customers
        get customers_path 
      }
      
      it 'return all customers' do
        expect(json['customers'].size).to be(10)
      end

      it 'status code' do
        expect(response).to have_http_status(200)
      end

    end

  end


end
