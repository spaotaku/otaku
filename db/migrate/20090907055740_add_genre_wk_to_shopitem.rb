class AddGenreWkToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :genre_wk, :string
  end

  def self.down
    remove_column :shopitems, :genre_wk
  end
end
