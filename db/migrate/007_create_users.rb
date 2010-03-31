class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    t.column :login,      :string
    t.column :password,   :string
    t.column :name,       :string
    t.column :email_pc,   :string
    t.column :email_cell, :string
    t.column :group_id,   :integer
    t.column :level,      :integer
    end
  end

  def self.down
    drop_table :users
  end
end
