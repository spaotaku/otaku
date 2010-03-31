class AddStrValToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :str_val_1, :string
    add_column :shopitems, :str_val_2, :string
    add_column :shopitems, :str_val_3, :string
    add_column :shopitems, :str_val_4, :string
    add_column :shopitems, :str_val_5, :string
    add_column :shopitems, :str_val_6, :string
    add_column :shopitems, :str_val_7, :string
    add_column :shopitems, :str_val_8, :string
    add_column :shopitems, :str_val_9, :string
    add_column :shopitems, :str_val_a, :string
    add_column :shopitems, :num_val_2, :integer
    add_column :shopitems, :num_val_3, :integer
    add_column :shopitems, :num_val_4, :integer
    add_column :shopitems, :num_val_5, :integer
    add_column :shopitems, :num_val_6, :integer
    add_column :shopitems, :num_val_7, :integer
    add_column :shopitems, :num_val_8, :integer
    add_column :shopitems, :num_val_9, :integer
    add_column :shopitems, :num_val_a, :integer
  end

  def self.down
    remove_column :shopitems, :str_val_1
    remove_column :shopitems, :str_val_2
    remove_column :shopitems, :str_val_3
    remove_column :shopitems, :str_val_4
    remove_column :shopitems, :str_val_5
    remove_column :shopitems, :str_val_6
    remove_column :shopitems, :str_val_7
    remove_column :shopitems, :str_val_8
    remove_column :shopitems, :str_val_9
    remove_column :shopitems, :str_val_a
    remove_column :shopitems, :num_val_2
    remove_column :shopitems, :num_val_3
    remove_column :shopitems, :num_val_4
    remove_column :shopitems, :num_val_5
    remove_column :shopitems, :num_val_6
    remove_column :shopitems, :num_val_7
    remove_column :shopitems, :num_val_8
    remove_column :shopitems, :num_val_9
    remove_column :shopitems, :num_val_a
  end
end
