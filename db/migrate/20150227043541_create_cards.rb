class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :original_text, null: false, default: ""
      t.string :translated_text, null: false, default: ""
      t.datetime :review_date

      t.timestamps null: false
    end
  end
end
