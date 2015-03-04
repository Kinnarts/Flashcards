class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = "Вы успешно вошли"
      redirect_back_or_to root_path
    else
      flash.now[:error] = 'Ошибка во время входа'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = "Произведен выход из системы!"
    redirect_to root_path
  end
end
