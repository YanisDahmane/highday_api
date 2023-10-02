class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:register, :login]

  def register
    @user = User.create!(register_params)
    if @user.save
      token = jwt_encode(user_id: @user.id)
      render json: { token: token, id: @user.id }, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token, id: @user.id }, status: :ok
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end

  def whoami
    render json: UserSerializer.new(@current_user).to_json, status: :ok
  end

  private

  def register_params
    params.permit(:firstname, :lastname, :email, :password)
  end

  def configure_profile_params
    params.permit(:type, :current_bankroll, :max_bankroll_use)
  end
end