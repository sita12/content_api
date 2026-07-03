module ApiAuthHelper
  def authentication_header(user)
    token = JsonWebToken.encode(user_id: user.id)
    { 'Authorization': "Bearer #{token}" }
  end
end
