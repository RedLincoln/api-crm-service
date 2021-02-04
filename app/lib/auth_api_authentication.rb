class AuthApiAuthentication
  class << self

    def get_user_token(login_params)
      response = Auth0Conf.post('/oauth/token', {
        headers: {
          "Content-type": "application/json",
        },
        body: {
          grant_type: "password",
          username: login_params[:username],
          password: login_params[:password],
          client_id: ENV['AUTH0_CLIENT_ID'],
          client_secret: ENV['AUTH0_CLIENT_SECRET'],
          audience: "https://#{ENV['AUTH0_DOMAIN']}/api/v2/",
          scope: "openid email"
        }.to_json
      })

      if response.code == 200
        JSON.parse(response.body)
      else
        nil
      end
    end


    def get_userinfo(token)
      response = Auth0Conf.get('/userinfo', {
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer #{token}"
        }
      })
      puts response

      if response.code == 200
        JSON.parse(response.body)
      else
        nil
      end
    end
  end
end