class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Пользователь успешно создан"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update(card_params)
      flash[:notice] = "Пользовательcкие данные изменены"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :authentications_attributes)
    end
end
