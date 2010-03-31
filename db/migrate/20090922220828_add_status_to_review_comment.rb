class AddStatusToReviewComment < ActiveRecord::Migration
  def self.up
    add_column :review_comments, :status, :integer
  end

  def self.down
    remove_column :review_comments, :status
  end
end
