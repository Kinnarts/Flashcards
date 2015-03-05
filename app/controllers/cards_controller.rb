class CardsController < ApplicationController
  before_action :find_card, :only_owner, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards.all
  end

  def show
  end

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      flash[:notice] = "Карточка создана успешно"
      redirect_to cards_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def find_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id)
  end

  def only_owner
    unless current_user == @card.user
      flash[:error] = "Только для создателей карточки"
      redirect_to login_path
    end
  end
end
