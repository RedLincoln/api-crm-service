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

end