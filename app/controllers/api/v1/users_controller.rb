class Api::V1::UsersController < ApplicationController
  before_action :authenticate
  load_and_authorize_resource
  
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

  def destroy 
    @user = User.find(params[:id])
    @user.delete
    render json: { message: 'User destroy' }
  end


  private

  def current_ability
    @current_ability ||= UserAbility.new(@user)  
  end

  def user_params
    if params.has_key?(:role)
      params.permit(:username, :password, :role).merge(role: Role.get_role_by_name(params[:role]))    
    else
      params.permit(:username, :params, :role)
    end
  end
end
