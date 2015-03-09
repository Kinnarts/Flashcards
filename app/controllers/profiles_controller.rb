class ProfilesController < ApplicationController
  def show
  end

  def edit
  end

  def set_current_pack
    if current_user.set_current_pack(user_params[:current_pack_id])
      flash[:notice] = "Колода для изучения изменена успешно"
    else
      flash[:error] = "Не удалось изменить колоду для изучения"
    end
    redirect_back_or_to packs_path
  end

  def update
    if current_user.update_attributes!(user_params)
      flash[:notice] = "Пользовательcкие данные изменены"
      redirect_back_or_to profile_path
    else
      render :edit
    end
  end

  private

  def user_params
    if params[:password].blank? && params[:password_confirmation].blank?
      params.require(:user).permit(:current_pack_id)
    else
      params.require(:user).permit(:email, :password, :password_confirmation, :current_pack_id)
    end
  end
end
