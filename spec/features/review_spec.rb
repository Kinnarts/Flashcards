require "rails_helper"
describe "review card" do
  let!(:user) { create(:user, email: "go@further.always", password: "freedom123", password_confirmation: "freedom123") }
  let!(:card) { create(:card, original_text: "review", translated_text: "перепросмотр", review_date: Time.now - 2.days, user: User.take) }

  before(:each) do
    login("go@further.always", "freedom123")
  end

  it "wrong" do
    fill_in "Введите перевод", with: "12345"
    click_button "Проверить"
    expect(page).to have_content "Ответ неверный, может повезет в следующий раз..."
  end

  it "success" do
    fill_in "Введите перевод", with: "Перепросмотр"
    click_button "Проверить"
    expect(page).to have_content "Поздравляем, все верно!"
  end
end
