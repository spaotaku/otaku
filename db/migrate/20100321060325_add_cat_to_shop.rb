class AddCatToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :cat_01,                   :string
    add_column :shops, :cat_02,                   :string
    add_column :shops, :what,                     :string
    add_column :shops, :when,                     :string
    add_column :shops, :where,                    :string
    add_column :shops, :entrance_fee,             :integer
    add_column :shops, :membership_fee_mon,       :integer
    add_column :shops, :membership_fee_year,      :integer
    add_column :shops, :membership_fee_remarks,   :string
    add_column :shops, :member_nr_m,              :integer
    add_column :shops, :member_nr_f,              :integer
    add_column :shops, :member_nr_all,            :integer
    add_column :shops, :member_remarks,           :string
    add_column :shops, :memo_02,                  :text
  end

  def self.down
    remove_column :shops, :cat_01
    remove_column :shops, :cat_02
    remove_column :shops, :what
    remove_column :shops, :when
    remove_column :shops, :where
    remove_column :shops, :entrance_fee
    remove_column :shops, :membership_fee_mon
    remove_column :shops, :membership_fee_year
    remove_column :shops, :membership_fee_remarks
    remove_column :shops, :member_nr_m
    remove_column :shops, :member_nr_f
    remove_column :shops, :member_nr_all
    remove_column :shops, :member_remarks
    remove_column :shops, :memo_02

  end
end
