require 'rails_helper'

RSpec.describe "Api::V1::Users POST /users", type: :request do
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:email) { 'email' }
  let(:role) { 'standard' }
  let(:total_users) { 2 }
  let(:user) { create(:user, username: username)}
  let(:admin_role) { create(:role, name: 'admin')}
  let(:admin) { create(:user, role: admin_role) }

  context 'authenticated admin' do

    context 'user does not exists' do
      
      before {
        user_authenticated(admin.email)
        create_user_auth0
        post users_path, params: { email: email, username: username, password: password, role: role },  headers: authorization_header
      }

      it 'create new user' do
        user = User.find_by(username: username)
        expect(User.count).to eq(total_users)
        expect(user.username).to eq(username)
        expect(user).to be_standard
      end

      it 'status code' do
        expect(response).to have_http_status(:created)
      end

    end

    context 'user does exist' do

      before {
        user
        user_authenticated(admin.email)
        conflict_create_user_auth0
        post users_path, params: { email: email, username: user.username, password: password },  headers: authorization_header
      }

      it 'status code' do
        expect(response).to have_http_status(:conflict)
      end
    end

    context 'missing required field' do
      
      before {
        user_authenticated(admin.email)
        create_user_auth0
        post users_path, params: { username: username, password: password, role: role },  headers: authorization_header
      }

      it 'status code' do
        expect(response).to have_http_status(:bad_request)
      end

    end

  end

  context 'not authenticated admin' do

    before {
      user_not_authenticated
      post users_path
    }

    it 'status code' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
