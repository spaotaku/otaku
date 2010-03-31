class AddRecruitmentToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :cat_00,                   :string
    add_column :shops, :recruitment,              :string
    add_column :shops, :representative,           :string
    add_column :shops, :officer,                  :string
    add_column :shops, :start_date,               :string
    add_column :shops, :juridical_person,         :string
    add_column :shops, :juridical_person_start_date,  :string
    add_column :shops, :purpose,                  :string
    add_column :shops, :event,                    :string
    add_column :shops, :main_cat,                 :string
    add_column :shops, :cat01,                   :string
    add_column :shops, :cat02,                   :string
    add_column :shops, :cat03,                   :string
    add_column :shops, :cat04,                   :string
    add_column :shops, :cat05,                   :string
    add_column :shops, :cat06,                   :string
    add_column :shops, :cat07,                   :string
    add_column :shops, :cat08,                   :string
    add_column :shops, :cat09,                   :string
    add_column :shops, :cat10,                   :string
    add_column :shops, :cat11,                   :string
    add_column :shops, :cat12,                   :string
    add_column :shops, :cat13,                   :string
    add_column :shops, :cat14,                   :string
    add_column :shops, :cat15,                   :string
    add_column :shops, :cat16,                   :string
    add_column :shops, :cat17,                   :string
  end

  def self.down
    remove_column :shops, :cat_00
    remove_column :shops, :recruitment
    remove_column :shops, :representative
    remove_column :shops, :officer
    remove_column :shops, :start_date
    remove_column :shops, :juridical_person
    remove_column :shops, :juridical_person_start_date
    remove_column :shops, :purpose
    remove_column :shops, :event
    remove_column :shops, :main_cat
    remove_column :shops, :cat01
    remove_column :shops, :cat02
    remove_column :shops, :cat03
    remove_column :shops, :cat04
    remove_column :shops, :cat05
    remove_column :shops, :cat06
    remove_column :shops, :cat07
    remove_column :shops, :cat08
    remove_column :shops, :cat09
    remove_column :shops, :cat10
    remove_column :shops, :cat11
    remove_column :shops, :cat12
    remove_column :shops, :cat13
    remove_column :shops, :cat14
    remove_column :shops, :cat15
    remove_column :shops, :cat16
    remove_column :shops, :cat17
  end
end
