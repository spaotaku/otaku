  require 'xmlrpc/client'
class Spot < ActiveRecord::Base
  validates_presence_of :name, :address
  belongs_to :user
  has_many :items, :dependent => :destroy
  has_many :shopitems

  def self.zip2address(zip)
    return [ '', '', '' ] if /^¥d{7}$/ =~ zip
    server = XMLRPC::Client.new('yubin.senmon.net', '/service/xmlrpc/')
    ary = server.call('yubin.fetchAddressByPostcode', zip.gsub('-','')).first
#    [ ary["pref"], (ary["city"]||'') + (ary["town"]||""), (ary["address"]||"") + (ary["other"]||"") ]
#    [ (ary["pref"]||'') + (ary["city"]||'') + (ary["town"]||"") + (ary["address"]||"") + (ary["other"]||""), (ary["city"]||'') + (ary["town"]||""), (ary["address"]||"") + (ary["other"]||"") ]
#    [ (ary["pref"]||'') + (ary["city"]||'') + (ary["town"]||"") + (ary["address"]||"") + (ary["other"]||"") ]
     (ary["pref"]||'') + (ary["city"]||'') + (ary["town"]||"") + (ary["address"]||"") + (ary["other"]||"")

  rescue
#    [ '', '', '' ]
#    [ '' ]
     ''
  end

  # check:小切手 or crejit_card:クレジットカード or parchace_order:購入要求書
  PUBLISH_LEVELS = [
    [ _('close'),      0 ],
    [ _('open_group'), 5 ],
    [ _('open_all'),   9 ]
  ].freeze    # freezeによって、この配列の値の変更を禁止する

end
