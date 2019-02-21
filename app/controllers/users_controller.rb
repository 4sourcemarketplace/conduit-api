# frozen_string_literal: true

class UsersController < ApplicationController

  before_action :authenticate_user!

  def show; end

  def update
    if current_user.update_attributes(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,:sign_in_count,:last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip,:updated_at, :email, :password, :bio, :image)
  end
end
