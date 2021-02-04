class Auth0Conf
  include HTTParty
  base_uri "https://#{ENV['AUTH0_DOMAIN']}"
end
