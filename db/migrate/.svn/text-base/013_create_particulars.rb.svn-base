class CreateParticulars < ActiveRecord::Migration
  def self.up
    create_table :particulars do |t|
      t.column :priority,         :integer
      t.column :seq,              :string
      t.column :name,             :string
      t.column :memo,             :text
      t.column :particularcat_id, :integer
      t.column :updated_on,       :datetime
    end  
  end

  def self.down
    drop_table :particulars
  end
end
