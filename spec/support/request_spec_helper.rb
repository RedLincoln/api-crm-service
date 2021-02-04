module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def authorization_header
    { "Authorization" => "token" }
  end
end