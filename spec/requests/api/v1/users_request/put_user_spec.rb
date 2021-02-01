require 'rails_helper'

RSpec.describe "Api::V1::Users PUT /users/:id", type: :request do
  let(:total_users) { 2 }
  let(:admin_username) { 'admin_username' }
  let(:user_username) { 'user_username'}
  let(:not_valid_username) { admin_username }
  let(:valid_username) { 'new username' }
  let(:admin_role) { create(:role, name: 'admin')}
  let(:admin) { create(:user, username: admin_username, role: admin_role) }
  let(:user) { create(:user, username: user_username)}
  let(:valid_user_id) { user.id}
  


  context 'authenticated admin' do

    before {
      admin; user
    }

    context 'user does no exists' do

      before {
        not_valid_id = User.order('id').last.try(:id).to_i + 1
        put user_path(not_valid_id), params: { username: valid_username }, headers: authorization_header(admin)
      }

      it 'status code' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user does exist' do

      context 'valid update params' do

        before { 
          put user_path(valid_user_id), params: { username: valid_username, role: 'admin' }, headers: authorization_header(admin)
        }

        it 'updated user' do
          expect(User.count).to be(total_users)
          expect(User.find(valid_user_id).username).to eq(valid_username)
          expect(User.find(valid_user_id)).to be_admin
          expect(json['user']['username']).to eq(valid_username)
        end

        it 'status code' do
          expect(response).to have_http_status(:ok)
        end

      end

      context 'not valid update params' do

        before { 
          put user_path(valid_user_id), params: { username: not_valid_username }, headers: authorization_header(admin)
        }

        it 'status code' do
          expect(response).to have_http_status(:conflict)
        end

      end

    end

  end

  context 'not authenticated admin' do

    before {
      put user_path(0)
    }

    it 'status code' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
