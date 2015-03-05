class HomeController < ApplicationController
  def index
    @card = current_user.cards.for_review.take
  end

  def check
    card = Card.find(params[:card_id])
    if card.check_translation(params[:q])
      flash[:notice] = "Поздравляем, все верно!"
    else
      flash[:error] = "Ответ неверный, может повезет в следующий раз..."
    end
    redirect_to root_path
  end
end
