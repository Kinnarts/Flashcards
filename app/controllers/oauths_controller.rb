class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      flash[:notice] = "Вход выполнен с данными из #{provider.titleize}!"
      redirect_to root_path
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        flash[:notice] = "Вход выполнен с данными из #{provider.titleize}!"
        redirect_to root_path
      rescue
        flash[:error] = "Вход с данными из #{provider.titleize} прошел неудачно!"
        redirect_to root_path
      end
    end
  end

  private
  def auth_params
    params.permit(:code, :provider)
  end
end
