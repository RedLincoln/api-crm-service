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
      render json: { error: @user.errors}, status: :conflict
    else
      @user = User.create(user_params)
      render json: { user: @user }, status: :created
    end
  end

  def update
    @user = User.find(params[:id])    
    @user.update(user_params)

    if @user.valid?
      render json: { user: @user }, status: :ok
    else
      render json: { error: @user.errors }, status: :conflict
    end

  end

  private

  def user_params
    if params.has_key?(:role)
      params.permit(:username, :password, :role).merge(role: Role.get_role_by_name(params[:role]))    
    else
      params.permit(:username, :params, :role)
    end
  end
end
