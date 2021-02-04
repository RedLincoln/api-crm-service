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
          grant_type: "client_credentials",
          client_id: ENV['AUTH0_CLIENT_ID'],
          client_secret: ENV['AUTH0_CLIENT_SECRET'],
          audience: "https://#{ENV['AUTH0_DOMAIN']}/api/v2/",
        }.to_json
      })
      
      if response.code == 200
        JSON.parse(response.body)
      else
        nil
      end
    end

    def create_user(user)
      response = Auth0Conf.post('/api/v2/users', {
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer #{self.get_api_token["access_token"]}"
        },
        body: {
          connection: ENV['AUTH0_CONNECTION'],
          email: user["email"],
          username: user["username"],
          password: user["password"],
          verify_email: false
        }.to_json
      })
        
      if response.code == 201 || response.code == 409
        JSON.parse(response.body)
      else
        nil
      end
    end

    
    def delete_user(uid)
      response = Auth0Conf.delete(URI.encode("/api/v2/users/#{uid}"), {
        headers: {
          "Authorization": "Bearer #{self.get_api_token["access_token"]}"
        }
      })

      response.code == 204
    end

    def update_user(uid:, update_params:)
      filtered_params = filter_valid_update_fields(update_params)
      return nil unless filtered_params.to_h.size > 0

      response = Auth0Conf.patch(URI.encode("/api/v2/users/#{uid}"), {
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer #{self.get_api_token["access_token"]}"
        },
        body: filter_valid_update_fields(update_params).merge({
          connection: ENV['AUTH0_CONNECTION'],
        }).to_json,
      })
      

      if response.code == 200
        JSON.parse(response.body)
      else
        nil
      end
    end

    private

    VALID_FIELDS = ["username", "password", "email"]

    def filter_valid_update_fields(params)
      params.select { |k, v| VALID_FIELDS.include?(k) }
    end
    
  end
end