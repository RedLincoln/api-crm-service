require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  let(:password) { 'password' }
  let(:bad_password) { 'password1' }
  let(:user) {create(:user, password: password)}

  describe 'login' do

    context 'good login' do

      before {
        login_token_mock
        post login_path, params: { username: user.username, password: password}
      }

      it 'status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'content' do
        expect(json).to include('access_token')
        expect(json).to include('user')
      end
    end

    context 'bad login' do

      before {
        bad_login_token_mock
        post login_path, params: { username: user.username, password: bad_password }
      }

      it 'status code' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'content' do
        expect(json).to include('error')
      end
    end
  end
end
