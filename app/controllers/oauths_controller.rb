class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    unless @user = login_from(provider)
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
      rescue
        flash[:error] = "Вход с данными из #{provider.titleize} прошел неудачно!"
        redirect_to root_path
      end
    end
    flash[:notice] = "Вход выполнен с данными из #{provider.titleize}!"
    redirect_to root_path
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
