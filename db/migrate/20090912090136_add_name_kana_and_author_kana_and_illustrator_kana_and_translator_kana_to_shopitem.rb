class AddNameKanaAndAuthorKanaAndIllustratorKanaAndTranslatorKanaToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :name_kana, :string
    add_column :shopitems, :author_kana, :string
    add_column :shopitems, :illustrator_kana, :string
    add_column :shopitems, :translator_kana, :string
  end

  def self.down
    remove_column :shopitems, :translator_kana
    remove_column :shopitems, :illustrator_kana
    remove_column :shopitems, :author_kana
    remove_column :shopitems, :name_kana
  end
end
