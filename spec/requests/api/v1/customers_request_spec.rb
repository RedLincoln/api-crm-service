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
    let(:total_customers) {10}
    let(:customers) {create_list(:customer, total_customers)}
    let(:valid_customer_id) {customers.first.id}

    
    context 'GET /customers' do
      before { customers; get customers_path }

      
      it 'return all customers' do
        expect(json['customers'].size).to be(total_customers)
      end

      it 'status code' do
        expect(response).to have_http_status(200)
      end

    end

    context 'GET /customers/:id' do

      describe 'with valid customer id' do
        before { get customer_path(valid_customer_id) }

        it 'content' do
          expect(json).to include('customer')
          expect(json['customer']['id']).to be(valid_customer_id)
        end
        
        it 'status code' do
          expect(response).to have_http_status(200)
        end
      end

      describe 'without valid customer id' do
        before {
          not_valid_customer_id = customers.sort_by(&:id).last.try(:id).to_i + 1
          get customer_path(not_valid_customer_id)
        }

        it 'status code' do
          expect(response).to have_http_status(404)
        end

      end
    end

  end


end
