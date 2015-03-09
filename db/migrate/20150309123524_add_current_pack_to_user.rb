class AddCurrentPackToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_pack_id, :integer
  end
end
