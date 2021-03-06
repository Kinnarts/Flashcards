class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
  end

  def create
    if @user = login(login_params[:email], login_params[:password])
      flash[:notice] = "Вы успешно вошли"
      redirect_back_or_to root_path
    else
      flash.now[:error] = "Ошибка во время входа"
      render "new"
    end
  end

  def destroy
    logout
    flash[:notice] = "Произведен выход из системы!"
    redirect_to root_path
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
