class AddCountsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :success_count_id, :integer, null: false, default: 0
    add_column :cards, :error_count_id, :integer, null: false, default: 0
  end
end
