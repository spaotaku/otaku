class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :priority,     :integer
      t.column :name,         :string
      t.column :memo,         :text
      t.column :updated_on,   :datetime
    end  
  end

  def self.down
    drop_table :categories
  end
end
