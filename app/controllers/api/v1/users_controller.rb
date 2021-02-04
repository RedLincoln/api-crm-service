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
      response = AuthApiManagment.create_user(user_params)
      
      case response.code
      when 201
        @user = User.create(user_params.merge(uid: JSON.parse(response.body)["user_id"]))
        render json: { user: @user }, status: :created
      when 409
        render json: { error: 'The user already exists' }, status: :conflict
      else
        render json: { error: 'Not possible to create user'}, status: :internal_server_error
      end
    else
      render json: { error: 'Email, username and password are required' }, status: :bad_request
    end
  end

  def update
    @user = User.find(params[:id])
    response =  AuthApiManagment.update_user(uid: @user.uid, update_params: user_params)
    
    case response.code
    when 200
      @user.update(user_params)
      render json: { user: @user }, status: :ok
    when 400
      render json: { error: 'Bad Request', message: JSON.parse(response.body)["message"] }, status: :bad_request
    else
      render json: { error: 'Not possible to update user'}, status: :internal_server_error
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
