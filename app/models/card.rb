class Card < ActiveRecord::Base
  before_create  :initialize_review_date
  validates :original_text, :translated_text, :user_id, :pack_id, presence: true
  validate :original_text_cannot_be_equal_translated_text
  belongs_to :user
  belongs_to :pack
  scope :for_review, -> { where("review_date <= ?", Time.now) }
  mount_uploader :photo, PhotoUploader

  def check_translation(text)
    if translated_text == prepare_for_check(text)
      success_check
    else
      error_check
    end
  end

  private

  def initialize_review_date
    self.review_date = Time.now unless review_date
  end

  def original_text_cannot_be_equal_translated_text
    if prepare_for_check(original_text) == prepare_for_check(translated_text)
      errors.add(:translated_text, "Не может быть такой же как оригинальный текст")
    end
  end

  def prepare_for_check(text)
    text.strip.mb_chars.downcase.to_s
  end

  def success_check
    case success_count_id
    when 0
      update_attributes(review_date: Time.now + 12.hours)
    when 1
      update_attributes(review_date: Time.now + 3.days)
    when 2
      update_attributes(review_date: Time.now + 7.days)
    when 3
      update_attributes(review_date: Time.now + 14.days)
    when 4
      update_attributes(review_date: Time.now + 1.month)
    else 
      update_attributes(review_date: Time.now + 1.month)
    end
    increment!(:success_count_id)
    update_attributes(error_count_id: 0)
  end

  def error_check
    increment!(:error_count_id)
    if error_count_id % 3 == 0
      decrement!(:success_count_id) unless success_count_id == 0
    end
  end
end
