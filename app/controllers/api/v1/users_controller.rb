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
    if have_required_params_for_create
      body = AuthApiManagment.create_user(user_params)
      if body
        @user = User.create(user_params.merge(uid: body["user_id"]))  
        render json: { user: @user }, status: :created if @user.persisted?
        render json: { error: 'Cant create user', message: 'Internal server error' }, status: :internal_server_error unless @user.persisted?
      elsif body["statusCode"] == :conflict
        render json: { error: 'The user already exists' }, status: :conflict
      end
    else
      render json: { error: 'Email, username and password are required'}
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    if @user.valid?
      AuthApiManagment.update_user(uid: @user.uid, update_params: user_params) unless params_only_contains_role
      render json: { user: @user }, status: :ok
    else
      render json: { error: @user.errors }, status: :conflict
    end  
  end

  def destroy 
    @user = User.find(params[:id])  
    if AuthApiManagment.delete_user(@user.uid)
      @user.delete
      render json: { message: 'User destroy' }
    else
      render json: { error: 'Cant destroy user', message: 'Internal server error' }, status: :internal_server_error
    end
  end


  private

  def current_ability
    @current_ability ||= UserAbility.new(@user)  
  end


  def params_only_contains_role
    !((user_params.has_key? :email) ||
      (user_params.has_key? :username) ||
      (user_params.has_key? :password))
  end

  def have_required_params_for_create
    (user_params.has_key? :email) &&
      (user_params.has_key? :username) && 
      (user_params.has_key? :password)
  end

  def user_params
    role = params.has_key?(:role) ? Role.get_role_by_name(params[:role]) : Role.get_role_by_name
    params.permit(:email, :username, :password, :role).merge(role: role)    
  end
end
