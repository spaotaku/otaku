class AddItemIdToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :item_id, :integer
  end

  def self.down
    remove_column :shopitems, :item_id
  end
end
