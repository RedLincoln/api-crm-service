require 'rails_helper'

RSpec.describe "Api::V1::Users GET /users", type: :request do
  let(:total_users) { 5 }
  let(:admin_role) { create(:role, name: 'admin')}
  let(:admin) { create(:user, role: admin_role) }
  let(:users) { create_list(:user, total_users - 1)}

  context 'authenticated admin' do

    before {
      users
      user_authenticated(admin.email)
      get users_path, headers: authorization_header
    }

    it 'returns all users' do
      expect(json['users'].size).to be(total_users)
    end

    it 'status code' do
      expect(response).to have_http_status(:ok)
    end

  end

  context 'not authenticated admin' do

    before {
      user_not_authenticated
      get users_path
    }

    it 'status code' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
