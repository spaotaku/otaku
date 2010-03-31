class AddFNameKanaAndLNameKanaAndAliasKanaToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :f_name_kana, :string
    add_column :students, :l_name_kana, :string
    add_column :students, :alias_kana, :string
  end

  def self.down
    remove_column :students, :alias_kana
    remove_column :students, :l_name_kana
    remove_column :students, :f_name_kana
  end
end
