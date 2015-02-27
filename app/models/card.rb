class Card < ActiveRecord::Base
  before_create :record_review_date

  private

  def record_review_date
    self.review_date = Time.now
  end
end
