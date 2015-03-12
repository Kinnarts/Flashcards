require "rails_helper"

describe Card do
  let!(:card) { create(:card, original_text: "factory", translated_text: "фабрика", user_id: 1, pack_id: 1) }

  it "has a valid translate" do
    expect(card.check_translation("фабрика")).to be true
  end

  it "has a valid translate with uppercase" do
    expect(card.check_translation("ФаБриКа")).to be true
  end

  it "has a valid translate with spaces form left and right" do
    expect(card.check_translation("   фабрика  ")).to be true
  end

  it "has a invalid translate" do
    expect(card.check_translation("something")).to_not be true
  end

  context "spaced repetiotion success" do

    it "change success_count_id" do
      expect{ card.check_translation("фабрика") }.to change(card, :success_count_id).by(1)
    end

    it "1-st change review_date at 12 hours" do
      card.success_count_id = 0
      expect{ card.check_translation("фабрика") }.to change{ card.review_date.to_i }.to((Time.now + 12.hours).to_i)
    end

    it "2-nd change review_date at 3 days" do
      card.success_count_id = 1
      expect{ card.check_translation("фабрика") }.to change{ card.review_date.to_i }.to((Time.now + 3.days).to_i)
    end

    it "3-rd change review_date at 1 week" do
      card.success_count_id = 2
      expect{ card.check_translation("фабрика") }.to change{ card.review_date.to_i }.to((Time.now + 7.days).to_i)
    end

    it "4-th change review_date at 2 weeks" do
      card.success_count_id = 3
      expect{ card.check_translation("фабрика") }.to change{ card.review_date.to_i }.to((Time.now + 14.days).to_i)
    end

    it "5-th change review_date at 1 month" do
      card.success_count_id = 4
      expect{ card.check_translation("фабрика") }.to change{ card.review_date.to_i }.to((Time.now + 1.month).to_i)
    end
  
    it "anything else change review_date at 1 month" do
      card.success_count_id = 10
      expect{ card.check_translation("фабрика") }.to change{ card.review_date.to_i }.to((Time.now + 1.month).to_i)
    end
  end

  context "spaced repetiotion error" do

    it "change error_count_id" do
      expect{ card.check_translation("qwerty") }.to change(card, :error_count_id).by(1)
    end

    it "3-rd should decrement success_count_id" do
      card.success_count_id = 3
      expect{ 3.times{ card.check_translation("qwerty") } }.to change(card, :success_count_id).by(-1)
    end
  end
end
