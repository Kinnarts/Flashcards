class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards.all
  end

  def show
  end

  def new
    if current_user.packs.count == 0
      flash[:error] = "Сначала нужно создать хотя бы одну колоду для карточек"
      redirect_to new_pack_path
    end
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
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :photo, :remote_photo_url, :photo_cache, :pack_id)
  end
end
