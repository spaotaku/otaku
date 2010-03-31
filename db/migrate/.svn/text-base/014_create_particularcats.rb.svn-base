class CreateParticularcats < ActiveRecord::Migration
  def self.up
    create_table :particularcats do |t|
      t.column :priority,       :integer
      t.column :name,           :string
      t.column :memo,           :text
      t.column :updated_on,     :datetime
    end  
  end

  def self.down
    drop_table :particularcats
  end
end
