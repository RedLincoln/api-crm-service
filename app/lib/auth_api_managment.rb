require 'uri'
require 'net/http'
require 'openssl'




class AuthApiManagment
  class << self 

    def get_api_token
      response = Auth0Conf.post('/oauth/token', {
        headers: {
          "content-type": "application/json",
        },
        body: {
          grant_type: "password",
          username: login_params[:email],
          password: login_params[:password],
          client_id: ENV['AUTH0_CLIENT_ID'],
          client_secret: ENV['AUTH0_CLIENT_SECRET'],
          audience: "https://#{ENV['AUTH0_DOMAIN']}/api/v2/",
          scope: ""
        }
      })
      
      puts response

      if response.code == 200
        response.body
      else
        nil
      end
    end

    def create_user(user)
      response = Auth0Conf.post('/api/v2/users', {
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer #{self.get_api_token[:access_token]}"
        },
        body: {
          connection: ENV['AUTH0_CONNECTION'],
          email: user[email],
          username: user[username],
          passowrd: user[password],
          verify_email: false
        }
      })
      
      puts response

      if response.code == 201
        response.body
      else
        nil
      end
    end

    
    def delete_user(user)
      response = Auth0Conf.delete("/api/v2/users/#{user[:uid]}")
      puts response

      response.code == 204
    end

    def update_user(uid:, update_params:)
      response = Auth0Conf.patch("/api/v2/users/#{user[:uid]}", {
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer #{self.get_api_token[:access_token]}"
        },
        body: update_params.merge({
          connection: ENV['AUTH0_CONNECTION'],
        }),
      })
      
      if response.code == 200
        response.body
      else
        nil
      end
    end

    
  end
end