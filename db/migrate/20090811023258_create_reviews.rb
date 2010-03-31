class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :shopitem_id
      t.integer :item_id
      t.integer :student_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
