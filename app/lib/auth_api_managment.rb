require 'uri'
require 'net/http'
require 'openssl'




class AuthApiManagment
  class << self 

    def get_api_token
      Auth0Conf.post('/oauth/token', {
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
    end

    def create_user(user)
      Auth0Conf.post('/api/v2/users', {
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer #{JSON.parse(self.get_api_token)["access_token"]}"
        },
        body: {
          connection: ENV['AUTH0_CONNECTION'],
          email: user["email"],
          username: user["username"],
          password: user["password"],
          verify_email: false
        }.to_json
      })
    end

    
    def delete_user(uid)
      response = Auth0Conf.delete(URI.encode("/api/v2/users/#{uid}"), {
        headers: {
          "Authorization": "Bearer #{JSON.parse(self.get_api_token)["access_token"]}"
        }
      })

      response.code == 204
    end

    def update_user(uid:, update_params:)
      filtered_params = filter_valid_update_fields(update_params)
      return nil unless filtered_params.to_h.size > 0

      Auth0Conf.patch(URI.encode("/api/v2/users/#{uid}"), {
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer #{JSON.parse(self.get_api_token)["access_token"]}"
        },
        body: filtered_params.merge({
          connection: ENV['AUTH0_CONNECTION'],
        }).to_json,
      })
    end

    private

    VALID_FIELDS = ["username", "email"]

    def filter_valid_update_fields(params)
      params.select { |k, v| VALID_FIELDS.include?(k) }
    end

  end
end