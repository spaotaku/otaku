require 'digest/sha1'

# this model expects a certain database layout and its based on the name/login pattern. 
class User < ActiveRecord::Base

  belongs_to :group
  has_many :items
  has_many :spots
  has_many :shop_items
  has_many :shops
  has_one :student

  def self.authenticate(login, pass)
    find(:first, :conditions => ["login = ? AND password = ?", login, sha1(pass)])
  end  

  def change_password(pass)
    update_attribute "password", self.class.sha1(pass)
  end

  def self.unsha1(pass)
    Digest::SHA1.digest(pass)
  end

  protected

  def self.sha1(pass)
    Digest::SHA1.hexdigest("change-me--#{pass}--")
  end
    
  before_create :crypt_password
#  before_update :crypt_password
  
  def crypt_password
    write_attribute("password", self.class.sha1(password))
  end

  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40 #, :on => :create
#  validates_presence_of :login, :password, :password_confirmation
  validates_presence_of :login, :password, :password_confirmation, :on => :create
  validates_presence_of :login
  validates_uniqueness_of :login, :on => :create
  validates_confirmation_of :password, :on => :create     
  validates_confirmation_of :password, :on => :update     
end
