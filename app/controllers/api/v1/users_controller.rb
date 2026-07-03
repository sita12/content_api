class Api::V1::UsersController < ApiController
  before_action :set_user, only: [ :login ]

  def create
    @user = User.new(user_params)
    if @user.save
      @token = JsonWebToken.encode(user_id: @user.id)
      render "show"
    else
      render json: { message: @user.errors }, status: :unprocessable_entity
    end
  end

  def login
    if @user && @user.authenticate(auth_params[:password])
      @token = JsonWebToken.encode(user_id: @user.id)
      render "show"
    else
      render json: { message: "Error: Invalid email or password" }, status: 400
    end
  end

  private
  def set_user
    @user = User.find_by_email(auth_params[:email])
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :country)
  end

  def auth_params
    params.require(:auth).permit(:email, :password)
  end
end
