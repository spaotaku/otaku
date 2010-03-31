class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.column :priority,     :integer
      t.column :title,        :string
      t.column :body,         :text
      t.column :memo,         :text
      t.column :org_e_mail,   :string
      t.column :org_url,      :string
      t.column :org_name,     :string
      t.column :source_url,   :string
      t.column :link_next,    :string
      t.column :link_prev,    :string
      t.column :updated_on,   :datetime
    end  
  end

  def self.down
    drop_table :messages
  end
end
