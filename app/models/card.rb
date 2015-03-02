class Card < ActiveRecord::Base
  before_create  :increase_review_date
  validates :original_text, :translated_text, presence: true
  validate :original_text_cannot_be_equal_translated_text
  scope :for_review, -> { where("review_date <= ?", Time.now) }

  def increase_review_date
    self.review_date = Time.now + 3.days    
  end

  def check_translation(text)
    if translated_text == prepare_for_check(text)
      update_attributes(review_date: Time.now + 3.days)
    end
  end

  private

  def original_text_cannot_be_equal_translated_text
    if prepare_for_check(original_text) == prepare_for_check(translated_text)
      errors.add(:translated_text, "Не может быть такой же как оригинальный текст")
    end
  end

  def prepare_for_check(text)
    text.strip.mb_chars.downcase.to_s
  end
end
