require 'rails_helper'

RSpec.describe "Api::V1::Customers", type: :request do

  context 'user authenticated' do
    let(:user) { create(:user)}

    before { user }

    describe 'initial state' do
      

      context 'GET /customers' do
        before { get customers_path, headers: authorization_header(user)}

        it 'no customers' do
          expect(json['customers']).to be_empty
        end
        
        it 'status code' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'GET /customer/:id' do
        before { get customer_path(0), headers: authorization_header(user)}

        it 'status code' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'POST /customers' do

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
      
    end

    describe 'with customers stored' do
      let(:total_customers) {10}
      let(:customers) {create_list(:customer, total_customers)}
      let(:valid_customer_id) {customers.first.id}

      
      context 'GET /customers' do
        before { customers; get customers_path, headers: authorization_header(user) }

        
        it 'return all customers' do
          expect(json['customers'].size).to be(total_customers)
        end

        it 'status code' do
          expect(response).to have_http_status(:ok)
        end

      end

      context 'GET /customer/:id' do

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
  end


  context 'user not authenticated' do

    it 'GET /customers' do
      get customers_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'GET /customer/:id' do
      get customer_path(0)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'POST /customers' do
      post customers_path
      expect(response).to have_http_status(:unauthorized)
    end

    it 'PUT /customer/:id' do
      put customer_path(0)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'DELETE /customer/:id' do
      delete customer_path(0)
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
