class CreateFacilities < ActiveRecord::Migration
  def self.up
    create_table :facilities do |t|
      t.column :priority,       :integer
      t.column :seq,            :string
      t.column :name,           :string
      t.column :memo,           :text
      t.column :facilitycat_id, :integer
      t.column :updated_on,     :datetime
    end  
  end

  def self.down
    drop_table :facilities
  end
end
