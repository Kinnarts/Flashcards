class AddBelongsToCards < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.belongs_to :pack, null: :false
    end
  end
end
