class HomeController < ApplicationController
  def index
    @card = Card.for_review.take
  end

  def check
    card = Card.find(params[:card_id])
    if card.check_translate(params[:q])
      flash[:notice] = "Поздравляем, все верно!"
    else
      flash[:error] = "Ответ неверный, может повезет в следующий раз..."
    end
    redirect_to root_path
  end
end
