class Card < ActiveRecord::Base
  before_create  :record_review_date
  validates :original_text, :translated_text, presence: true
  validate :original_text_cannot_be_equal_translated_text

  private

  def record_review_date
    self.review_date = Time.now + (60 * 60 * 72)
  end

  def original_text_cannot_be_equal_translated_text
    if self.original_text.mb_chars.downcase.to_s == self.translated_text.mb_chars.downcase.to_s
      errors.add(:translated_text, "Не может быть такой же как оригинальный текст")
    end
  end
end
