class Api::V1::UsersController < ApplicationController
  before_action :authenticate
  
  
  def index
    @users = User.all
    render json: { users: @users }
  end

end
