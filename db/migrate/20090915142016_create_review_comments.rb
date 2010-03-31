class CreateReviewComments < ActiveRecord::Migration
  def self.up
    create_table :review_comments do |t|
      t.string  :name
      t.text    :content
      t.integer :student_id
      t.integer :review_id

      t.timestamps
    end
  end

  def self.down
    drop_table :review_comments
  end
end
