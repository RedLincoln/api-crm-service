module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authorization_header(user)
    token = JsonWebTokens.encode_token({user_id: user.id})
    { 'Authorization' => "Bearer #{token}"}
  end
end