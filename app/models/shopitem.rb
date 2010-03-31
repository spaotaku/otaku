class Shopitem < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  belongs_to :shop
  belongs_to :item
  belongs_to :spot
  has_many :pictures, :dependent => :destroy
  has_many :reviews
  
  PUBLISH_LEVELS = [
    [ _('close'),      0 ],
    [ _('open_group'), 5 ],
    [ _('open_all'),   9 ]
  ].freeze    # freezeによって、この配列の値の変更を禁止する

  validates_presence_of :name, :name_kana, :shop_id
#  validates_presence_of :name, :name_kana, :author, :author_kana, :publish_level, :shop_id

end
