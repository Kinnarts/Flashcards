class AddPhotoToCards < ActiveRecord::Migration
  def change
    add_column :cards, :photo, :string
  end
end
