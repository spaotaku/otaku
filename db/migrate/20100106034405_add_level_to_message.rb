class AddLevelToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :level, :integer
  end

  def self.down
    remove_column :messages, :level
  end
end
