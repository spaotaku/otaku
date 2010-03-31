class Item < ActiveRecord::Base

# validates_numericality_of :num_val_1, :only_integer => true, :allow_nil => true
  belongs_to :user
  belongs_to :spot
  belongs_to :category
  belongs_to :structure
  belongs_to :shop
  has_many :pictures, :dependent => :destroy
  has_many :students, :dependent => :destroy
  has_many :reviews
  has_many :shopitems
  has_one :group

  # check:小切手 or crejit_card:クレジットカード or parchace_order:購入要求書
  PUBLISH_LEVELS = [
    [ _('close'),      0 ],
    [ _('open_group'), 5 ],
    [ _('open_all'),   9 ]
  ].freeze    # freezeによって、この配列の値の変更を禁止する

  TORIHIKI_TAIYOU = [
    [ _('baikai'),      1 ],
    [ _('kasinusi'),    2 ],
    [ _('urinusi'),     3 ],
    [ _('dairi'),       4 ],
    [ _('other'),       9 ]
  ].freeze    # freezeによって、この配列の値の変更を禁止する

  validates_presence_of :name, :spot_id, :shop_id, :num_val_o, :publish_level, :num_val_1
  validates_presence_of :category_id


end
