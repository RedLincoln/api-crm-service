class Api::V1::AuthController < ApplicationController
  before_action :user_params, except: [:auto_login]
  before_action :authorized, except: [:login]

  def login 
    @user = User.find_by(username: params[:username])  

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: { user: @user, token: token}
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  def auto_login
    render json: @user
  end

  private 

  def user_params
    params.permit(:username, :password)
  end
end