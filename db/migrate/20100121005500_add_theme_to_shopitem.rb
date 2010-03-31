class AddThemeToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :theme, :string
    add_column :shopitems, :theme_wk, :string
  end

  def self.down
    remove_column :shopitems, :theme
    remove_column :shopitems, :theme_wk
  end
end
