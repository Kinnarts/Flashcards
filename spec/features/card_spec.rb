require "rails_helper"
describe "Card" do
  before(:all) do
    @card = create(:card)
  end

  before(:each) do
    visit root_path
  end

  it "root path" do
    expect(page).to have_content "Карточка для повторения"
  end

  it "can create new card" do
    click_link "Добавить карточку"
    create_card(@card.original_text, @card.translated_text)
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
  
  context "review card" do
    before(:each) do
      Card.first.update_attributes(review_date: Time.now - 2.days)
      click_link "Флешкарточкер"
    end

    it "wrong" do
      fill_in "Введите перевод", with: "12345"
      click_button "Проверить"
      expect(page).to have_content "Ответ неверный, может повезет в следующий раз..."
    end

    it "succes" do
      fill_in "Введите перевод", with: @card.translated_text
      click_button "Проверить"
      expect(page).to have_content "Поздравляем, все верно!"
    end
  end
end
