class CreateShopitems < ActiveRecord::Migration
  def self.up
    create_table :shopitems do |t|
    t.column :name,          :string
    t.column :created_at,    :timestamp
    t.column :num_val_1,     :integer
    t.column :memo,          :text
    t.column :shop_id,       :integer
    t.column :title,         :text
    t.column :content,       :text
    t.column :user_id,       :integer
    t.column :publish_level, :integer
    t.column :tag,           :text
    t.column :group_id,      :integer
    end
  end

  def self.down
    drop_table :shopitems
  end
end
