class AddSpotIdToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :spot_id, :integer
  end

  def self.down
    remove_column :shopitems, :spot_id
  end
end
