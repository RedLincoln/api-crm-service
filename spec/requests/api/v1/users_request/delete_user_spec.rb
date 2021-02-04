require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:total_users) { 2 }
  let(:admin_role) { create(:role, name: 'admin')}
  let(:admin) { create(:user, role: admin_role) }
  let(:user) { create(:user)}
  let(:valid_user_id) { user.id }

  context 'authenticated admin' do

    before {
      admin; user
      user_authenticated(admin.email)
    }

    context 'user does exist' do

      before {
        delete_user_auth0
        delete user_path(valid_user_id), headers: authorization_header
      }

      it 'deletes the user' do
        expect(User.count).to be(total_users - 1)
        expect{ User.find(valid_user_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'status code' do
        expect(response).to have_http_status(:ok)
      end

    end

    context 'user doest not exists' do
      before {
        delete_user_doesnt_exists_auth0
        not_valid_id = User.order('id').last.try(:id).to_i + 1
        delete user_path(not_valid_id), headers: authorization_header
      }

      it 'status code' do
        expect(response).to have_http_status(:not_found)
      end

    end

  end

  context 'not authenticated admin' do

    before {
      user_not_authenticated
      delete user_path(0)
    }

    it 'status code' do
      expect(response).to have_http_status(:unauthorized)
    end

  end

end
