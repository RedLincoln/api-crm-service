require 'rails_helper'

RSpec.describe "Api::V1::Customers", type: :request do

  describe 'initial state' do

    context 'GET /customers' do
      before{get customers_path}

      it 'no customers' do
        expect(json['customers']).to be_empty
      end
      
      it 'status code' do
        expect(response).to have_http_status(200)
      end
    end
    
  end


end
