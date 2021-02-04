require 'rails_helper'

RSpec.describe "Api::V1::Users GET /users/:id", type: :request do
  let(:total_users) { 3 }
  let(:admin_role) { create(:role, name: 'admin')}
  let(:admin) { create(:user, role: admin_role) }
  let(:users) { create_list(:user, total_users - 1)}
  let(:valid_user_id) { users.first.id }

  context 'authenticated admin' do

    context 'user exists' do

      before {
        user_authenticated(admin.email)
        get user_path(valid_user_id), headers: authorization_header
      }

      it 'returns the user requested' do
        expect(json['user']['id']).to eq(valid_user_id)
      end

      it 'status code' do
        expect(response).to have_http_status(:ok)
      end

    end

    context 'user doest not exists' do

      before {
        not_valid_id = User.order('id').last.try(:id).to_i + 1
        user_authenticated(admin.email)
        get user_path(not_valid_id), headers: authorization_header
      }

      it 'status code' do
        expect(response).to have_http_status(:not_found)
      end

    end
  end
  
  context 'not authenticated admin' do

    before {
      user_not_authenticated
      get user_path(0)
    }

    it 'status code' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
