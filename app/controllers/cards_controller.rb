class CardsController < ApplicationController
  before_action :find_card, only: [:show]

  def index
    @cards = Card.all
  end

  def show
    @card.review_date = Time.now
    @card.save
  end

  private

  def find_card
    @card = Card.find(params[:id])
  end

end