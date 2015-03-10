def create_card(original_text, translated_text,pack_name)
  visit new_card_path
  fill_in "Оригинальный текст", with: original_text
  fill_in "Перевод", with: translated_text
  select pack_name, from: "Выберите колоду"
  click_button "Create Card"
end
