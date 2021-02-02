class Api::V1::AuthController < ApplicationController
  before_action :user_params

  def login 
    @user = User.find_by(username: user_params[:username])  

    if @user && @user.authenticate(user_params[:password])
      token = JsonWebTokens.encode_token({user_id: @user.id})
      render json: { user: @user, token: token}
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  private 

  def user_params
    params.permit(:username, :password)
  end
end
