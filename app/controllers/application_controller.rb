class ApplicationController < ActionController::API

  rescue_from CanCan::AccessDenied do
    render json: {error: 'Access denied' }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Not Found'}, status: :not_found
  end


  def authenticate
    render json: {error: 'Unauthorized'}, status: :unauthorized unless !!logged_in_user
  end

  private

  def auth_token
    request.headers['Authorization']
  end

  def logged_in_user
    if auth_token
      token = auth_token.split(' ').last
      userinfo = AuthApiAuthentication.get_userinfo(token)
      @user = User.find_by(email: userinfo["email"])
    end
  end

end
