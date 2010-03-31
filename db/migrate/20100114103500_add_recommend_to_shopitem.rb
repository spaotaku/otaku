class AddRecommendToShopitem < ActiveRecord::Migration
  def self.up
    add_column :shopitems, :recommend_grade_flg_00, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_01, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_02, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_03, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_04, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_05, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_06, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_07, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_08, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_09, :boolean, :null => false , :default => false
    add_column :shopitems, :recommend_grade_flg_10, :boolean, :null => false , :default => false
  end

  def self.down
    remove_column :shopitems, :recommend_grade_flg_00
    remove_column :shopitems, :recommend_grade_flg_01
    remove_column :shopitems, :recommend_grade_flg_02
    remove_column :shopitems, :recommend_grade_flg_03
    remove_column :shopitems, :recommend_grade_flg_04
    remove_column :shopitems, :recommend_grade_flg_05
    remove_column :shopitems, :recommend_grade_flg_06
    remove_column :shopitems, :recommend_grade_flg_07
    remove_column :shopitems, :recommend_grade_flg_08
    remove_column :shopitems, :recommend_grade_flg_09
    remove_column :shopitems, :recommend_grade_flg_10
  end
end
