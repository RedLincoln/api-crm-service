module AuthSpecHelper

  BASE_URI = "https://#{ENV['AUTH0_DOMAIN']}"

  def login_token_mock
    stub_request(:post, "#{BASE_URI}/oauth/token").
      with(body: hash_including(grant_type: "password")).
      to_return(status: 200,
                body: {
                  access_token: "random access token"
                }.to_json)

  end

  def bad_login_token_mock
    stub_request(:post, "#{BASE_URI}/oauth/token").
      with(body: hash_including(grant_type: "password")).
      to_return(status: 401)

  end

  def user_authenticated(user_email)
    stub_request(:get, "#{BASE_URI}/userinfo").
      to_return(status: 200,
                body: {
                  email: user_email
                }.to_json)
  end

  def user_not_authenticated
    stub_request(:get, "#{BASE_URI}/userinfo").
      to_return(status: 401)
  end
  
  def get_management_api_token
    stub_request(:post, "#{BASE_URI}/oauth/token").
      with(body: hash_including(grant_type: "client_credentials")).
      to_return(status: 200,
                body: {
                  access_token: "random access token"
                }.to_json)
  end

  def create_user_auth0
    get_management_api_token
    stub_request(:post, "#{BASE_URI}/api/v2/users").
      to_return(status: 201,
                body: {
                  user_id: "auth0_id"
                }.to_json)
  end

  def conflict_create_user_auth0
    get_management_api_token
    stub_request(:post, "#{BASE_URI}/api/v2/users").
      to_return(status: 409,
                body: {
                  statusCode: 409
                }.to_json)
  end

  def delete_user_auth0
    get_management_api_token
    stub_request(:delete, "#{BASE_URI}/api/v2/users/").
      to_return(status: 204)
  end

  def delete_user_doesnt_exists_auth0
    get_management_api_token
    stub_request(:delete, "#{BASE_URI}/api/v2/users/").
      to_return(status: 404)
  end

  def update_user_auth0
    get_management_api_token
    stub_request(:patch, "#{BASE_URI}/api/v2/users/").
      to_return(status: 200, body: {}.to_json)
  end

  def update_user_conflict_auth0
    get_management_api_token
    stub_request(:patch, "#{BASE_URI}/api/v2/users/").
      to_return(status: 400, body: {}.to_json)
  end

  def update_user_doesnt_exists_auth0
    get_management_api_token
    stub_request(:patch, "#{BASE_URI}/api/v2/users/").
      to_return(status: 404)
  end

end