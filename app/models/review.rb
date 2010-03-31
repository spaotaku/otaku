class Review < ActiveRecord::Base
#  validates_presence_of :f_name, :l_name, :age
# validates_numericality_of :num_val_1, :only_integer => true, :allow_nil => true
  belongs_to :item
  belongs_to :shopitem
  belongs_to :student
  has_many :pictures, :dependent => :destroy
  has_many :review_comment, :dependent => :destroy

  STATUS = [
    [ _('submited'),      1 ],
    [ _('reviewing'),     2 ],
    [ _('published'),     3 ],
    [ _('holding'),       4 ]
  ].freeze    # freezeによって、この配列の値の変更を禁止する

validates_presence_of :shopitem_id, :body, :status

end
