class HomeController < ApplicationController
  def index
    @card = if current_user.current_pack_id 
      current_user.current_pack.cards.for_review.take
    else
      current_user.cards.for_review.take
    end
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
