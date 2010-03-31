class AddStatusToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :status, :integer
  end

  def self.down
    remove_column :reviews, :status
  end
end
