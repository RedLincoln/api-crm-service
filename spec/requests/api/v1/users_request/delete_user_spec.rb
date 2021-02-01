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
    }

    context 'user does exist' do

      before {
        delete user_path(valid_user_id), headers: authorization_header(admin)
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
        not_valid_id = User.order('id').last.try(:id).to_i + 1
        delete user_path(not_valid_id), headers: authorization_header(admin)
      }

      it 'status code' do
        expect(response).to have_http_status(:not_found)
      end

    end

  end

  context 'not authenticated admin' do

    before {
      delete user_path(0)
    }

    it 'status code' do
      expect(response).to have_http_status(:unauthorized)
    end

  end

end
