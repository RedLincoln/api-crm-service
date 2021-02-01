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
end
