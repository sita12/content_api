class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :underscore_params!

  private
  def authorize_request
    header = request.headers["Authorization"]
    header.nil? ? render_api_message("Error: Unauthorized Access", :unauthorized) : token_auth(header.split(" ")[1])
  end

  def token_auth(header)
    begin
      token = JsonWebToken.decode(header)
      token.blank? ? render_api_message("Error: Token is expired or invalid", :unauthorized) : token_user(token)
    rescue JWT::DecodeError => e
      render json: { message: e.message, status: 401 }, status: :unauthorized
    end
  end

  def token_user(token)
    @user = User.find_by_id(token[:user_id])
    render_api_message("Error: Token is expired or invalid", :unauthorized) if @user.nil?
  end

  def render_api_message(message, status)
    render json: { message: message }, status: status
  end

  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end
