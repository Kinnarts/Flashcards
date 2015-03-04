require "rails_helper"
describe "Card management" do
  let!(:user) { create(:user, email: "go@further.always", password: "freedom123", password_confirmation: "freedom123") }
  let!(:card) { create(:card, user: User.take) }

  before(:each) do
    login("go@further.always", "freedom123")
  end

  it "root path" do
    expect(page).to have_content "Карточка для повторения"
  end

  it "can create new card" do
    click_link "Добавить карточку"
    create_card(card.original_text, card.translated_text)
    expect(page).to have_content "Карточка создана успешно"
  end

  it "cards path" do
    click_link "Все карточки"
    expect(page).to have_content "Список всех карточек"
  end

  it "can edit card" do
    visit cards_path
    click_link "Редактировать"
    expect(page).to have_content "Введите новые данные"
  end
end
