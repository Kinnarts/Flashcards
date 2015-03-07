class ProfilesController < ApplicationController
  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "Пользовательcкие данные изменены"
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
