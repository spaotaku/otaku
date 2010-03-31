class AddGenreNrpageHeroPublishdateToShopitems < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :genre, :string
    add_column :shopitems, :nr_pages, :integer
    add_column :shopitems, :hero, :string
    add_column :shopitems, :publish_date, :datetime
  end

  def self.down
    remove_column :shopitems, :publish_date
    remove_column :shopitems, :hero
    remove_column :shopitems, :nr_pages
    remove_column :shopitems, :genre
  end
end
