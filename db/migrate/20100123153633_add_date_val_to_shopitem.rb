class AddDateValToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :date_val_1, :datetime
    add_column :shopitems, :date_val_2, :datetime
    add_column :shopitems, :date_val_3, :datetime
    add_column :shopitems, :date_val_4, :datetime
    add_column :shopitems, :date_val_5, :datetime
  end

  def self.down
    remove_column :shopitems, :date_val_1
    remove_column :shopitems, :date_val_2
    remove_column :shopitems, :date_val_3
    remove_column :shopitems, :date_val_4
    remove_column :shopitems, :date_val_5
  end
end
