def create_card(original_text, translated_text)
  visit new_card_path
  fill_in "Оригинальный текст", with: original_text
  fill_in "Перевод", with: translated_text
  select "1", from: "User"
  click_button "Create Card"
end
