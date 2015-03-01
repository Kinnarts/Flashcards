class HomeController < ApplicationController
  def index
    @card = Card.all_for_review.take
  end

  def check
    card = Card.find(params[:card_id])
    if card.check_translate(params[:q])
      flash[:notice] = "Поздравляем, все верно!"
      card.increase_review_date
      card.save
      redirect_to root_path
    else
      flash[:error] = "Ответ неверный, может повезет в следующий раз..."
      redirect_to root_path
    end
  end
end
