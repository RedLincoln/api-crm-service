class ApplicationController < ActionController::API

  rescue_from CanCan::AccessDenied do
    render json: {error: 'Access denied' }, status: :forbidden
  end

  def logged_in_user
    decoded = JsonWebTokens.decode_token(request)
    if decoded
      user_id = decoded[0]['user_id']
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end


  def authenticate
    render json: {error: 'Unauthorized'}, status: :unauthorized unless logged_in?
  end
end
