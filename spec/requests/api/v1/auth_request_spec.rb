require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  let(:password) { 'password' }
  let(:user) {create(:user, password: password)}

  describe 'login' do

    context 'good login' do

      before {
        post login_path, params: { username: user.username, password: password}
      }

      it 'status code' do
        expect(response).to have_http_status(200)
      end

      it 'content' do
        expect(json).to include('token')
        expect(json).to include('user')
      end
    end

  end
end
