class ApplicationController < ActionController::API

  def current_user 
    @user
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
