class AddDiflgToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :di_flg, :boolean, :null => false , :default => false
  end

  def self.down
    remove_column :shopitems, :di_flg
  end
end
