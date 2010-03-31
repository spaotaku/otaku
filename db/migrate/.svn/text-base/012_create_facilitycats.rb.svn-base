class CreateFacilitycats < ActiveRecord::Migration
  def self.up
    create_table :facilitycats do |t|
      t.column :priority,       :integer
      t.column :seq,            :string
      t.column :name,           :string
      t.column :memo,           :text
      t.column :updated_on,     :datetime
    end  
  end

  def self.down
    drop_table :facilitycats
  end
end
