class AddReviewIdToPicture < ActiveRecord::Migration
  def self.up
    add_column :pictures, :review_id, :integer
  end

  def self.down
    remove_column :pictures, :review_id
  end
end
