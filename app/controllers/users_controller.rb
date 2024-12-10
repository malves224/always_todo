class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.messages.values.flatten }, status: :unprocessable_entity
    end
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
