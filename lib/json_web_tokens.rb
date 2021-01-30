class JsonWebTokens
  class << self 

    def encode_token(payload)
      JWT.encode(payload, ENV['JWT_SECRET'])
    end

    def decode_token(request)
      auth_header = request.headers['Authorization']
      if auth_header
        token = auth_header.split(' ')[1]
        begin
          JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end

  end
end