class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.integer :item_id
      t.string :f_name
      t.string :m_name
      t.string :l_name
      t.integer :age
      t.text :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
