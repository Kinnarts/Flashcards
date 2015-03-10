require "rails_helper"
describe "Pack management" do
  let!(:user) { create(:user, email: "go@further.always", password: "freedom123", password_confirmation: "freedom123") }
  let!(:pack) { create(:pack, user: User.take) }
  let!(:card) { create(:card, user: User.take, pack: Pack.take) }

  before(:each) do
    login("go@further.always", "freedom123")
  end

  it "can create new pack" do
    click_link "Мои колоды"
    create_pack(pack.name)
    expect(page).to have_content "Колода создана успешно"
  end

  it "packs path" do
    click_link "Мои колоды"
    expect(page).to have_content "Список всех колод"
  end

  it "can edit pack" do
    visit packs_path
    click_link "Редактировать"
    expect(page).to have_content "Введите новые данные"
  end

  it "can edit current_pack" do
    visit packs_path
    select pack.name, from: "Выберите колоду для изучения"
    click_button "Save User"
    expect(page).to have_content "Колода для изучения изменена успешно"
  end
end
