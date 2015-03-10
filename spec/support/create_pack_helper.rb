def create_pack(name)
  visit new_pack_path
  fill_in "Имя колоды", with: name
  click_button "Create Pack"
end
