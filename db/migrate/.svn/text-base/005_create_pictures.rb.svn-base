class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.column :title,        :string
      t.column :name,         :string
      t.column :size,         :integer
      t.column :content_type, :string
      t.column :image,        :longblob
      t.column :item_id,      :integer
      t.column :shopitem_id,  :integer
    end
  end

  def self.down
    drop_table :pictures
  end
end
