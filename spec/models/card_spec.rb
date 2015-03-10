require "rails_helper"

describe Card do
  before :each do
    @card = Card.new(original_text: "factory", translated_text: "фабрика", review_date: Time.now - 3.days, user_id: 1, pack_id: 1)
  end

  it "has a valid translate" do
    expect(@card.check_translation("фабрика")).to be true
  end

  it "has a valid translate with uppercase" do
    expect(@card.check_translation("ФаБриКа")).to be true
  end

  it "has a valid translate with spaces form left and right" do
    expect(@card.check_translation("   фабрика  ")).to be true
  end

  it "has a invalid translate" do
    expect(@card.check_translation("something")).to_not be true
  end

  it "valid translate should change review_date" do
    expect{ @card.check_translation("фабрика") }.to change{ @card.review_date.to_i }.to((Time.now + 3.days).to_i)
  end
end
