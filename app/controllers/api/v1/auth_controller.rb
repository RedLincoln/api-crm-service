class Api::V1::AuthController < ApplicationController

  def login 
    body = AuthApiAuthentication.get_user_token(user_params)
    if body
      render json: { user: User.find_by(email: user_params["email"]).to_json,  access_token: body["access_token"]}
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private 

  def user_params
    params.permit(:username, :password)
  end
end
