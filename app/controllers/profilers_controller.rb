class ProfilersController < ApplicationController
  def show
  end

  def edit
  end

  def update
    unless current_user.update(user_params)
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
