class AddAuthorAndIllustratorAndAmazonUrlToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :author, :string
    add_column :shopitems, :illustrator, :string
    add_column :shopitems, :translator, :string
    add_column :shopitems, :amazon_url, :string
  end

  def self.down
    remove_column :shopitems, :amazon_url
    remove_lolumn :shopitems, :translator
    remove_column :shopitems, :illustrator
    remove_column :shopitems, :author
  end
end
