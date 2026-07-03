class Api::V1::ContentsController < ApiController
  before_action :authorize_request
  before_action :set_content,  only: [ :update, :destroy ]

  def index
    @contents = Content.includes(:user).all
  end

  def show
    @content = Content.find_by_id(params[:id])
    if @content.nil?
      render json: { message: "Error: Content Not Foound" }, status: 400
    end
  end

  def update
    if @content.update(content_params)
      render "show"
    else
      render json: { message: @content.errors }, status: :unprocessable_entity
    end
  end

  def create
    @content = @user.contents.new(content_params)
    if @content.save
      render "show"
    else
      render json: { message: @content.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @content.destroy
      render json: { message: "Deleted" }, status: 200
    else
      render json: { message: @content.errors }, status: :unprocessable_entity
    end
  end

  private
  def set_content
    @content = @user.contents.find_by_id(params[:id])
    if @content.nil?
      render json: { message: "Error: Unauthorized Access" }, status: :unauthorized
    end
  end

  def content_params
    params.permit(:id, :title, :body)
  end
end
