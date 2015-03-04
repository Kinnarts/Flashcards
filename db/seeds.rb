# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "nokogiri"
require "open-uri"

u = User.create!(email: "go@further.always", password: "freedom123", password_confirmation: "freedom123")

doc = Nokogiri::HTML(open("http://en365.ru/top100.htm"))
table = doc.css("table[width='60%']").css("td")
3.step((table.size - 3), 3) do |i|
  original_text = table[i + 1].children.text
  translated_text = table[i + 2].children.text
  Card.create(original_text: original_text, translated_text: translated_text, user_id: u.id)
end
