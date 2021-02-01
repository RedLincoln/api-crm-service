class Api::V1::UsersController < ApplicationController
  before_action :authenticate
  
  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Not Found'}, status: :not_found
  end
  
  def index
    @users = User.all
    render json: { users: @users }
  end


  def show
    @user = User.find(params[:id])
    render json: { user: @user }
  end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user
      render json: { error: "User with username #{user_params[:username]} already exists"}, status: :conflict
    else
      role = Role.get_role_by_name(user_params[:role])
      @user = User.create(user_params.merge(role: role))
      render json: { user: @user }, status: :created
    end
  end

  private

  def user_params
    params.permit(:username, :password, :role)
  end
end
