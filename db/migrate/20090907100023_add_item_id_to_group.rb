class AddItemIdToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :item_id, :integer
  end

  def self.down
    remove_column :groups, :item_id
  end
end
