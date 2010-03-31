class CreateSpots < ActiveRecord::Migration
  def self.up
  create_table :spots do |t|
    t.column :name,                          :string
    t.column :address,                       :string
    t.column :phone,                         :string
    t.column :fax,                           :string
    t.column :memo,                          :text
    t.column :longitude,                     :decimal,              :precision => 17, :scale => 14, :default => 0.0, :null => false
    t.column :latitude,                      :decimal,              :precision => 17, :scale => 15, :default => 0.0, :null => false
    t.column :homepage,                      :string
    t.column :email_1,                       :string
    t.column :image_url,                     :string
    t.column :longitude_tokyo_datum_dec,     :decimal,              :precision => 17, :scale => 14, :default => 0.0, :null => false
    t.column :latitude_tokyo_datum_dec,      :decimal,              :precision => 17, :scale => 15, :default => 0.0, :null => false
    t.column :longitude_tokyo_datum_ddmmsss, :string
    t.column :latitude_tokyo_datum_ddmmsss,  :string
    t.column :user_id,                       :integer
    t.column :group_id,                      :integer
    t.column :publish_level,                 :integer
    t.column :address_wk1,                   :string
    t.column :zip,                           :string,  :limit => 8
    t.column :prefecture,                    :string
    t.column :address1,                      :string
    t.column :address2,                      :string
    t.column :building,                      :string
    t.column :text1,                         :string
    t.column :text2,                         :string
    t.column :text3,                         :string
    t.column :text4,                         :string
    t.column :text5,                         :string
    end
  end

  def self.down
    drop_table :spots
  end
end
