class AddSexAliasBirthdayLnameinitialToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :sex, :integer
    add_column :students, :birthday, :datetime
    add_column :students, :l_name_initial, :string
    add_column :students, :alias, :string
  end

  def self.down
    remove_column :students, :alias
    remove_column :students, :l_name_initial
    remove_column :students, :birthday
    remove_column :students, :sex
  end
end
