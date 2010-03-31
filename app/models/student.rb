class Student < ActiveRecord::Base

# validates_numericality_of :num_val_1, :only_integer => true, :allow_nil => true
  belongs_to :item
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  has_many :reviews

  GRADE = [
    [ _('grade_k'), 0 ],
    [ _('grade_1'), 1 ],
    [ _('grade_2'), 2 ],
    [ _('grade_3'), 3 ],
    [ _('grade_4'), 4 ],
    [ _('grade_5'), 5 ],
    [ _('grade_6'), 6 ],
    [ _('grade_7'), 7 ],
    [ _('grade_8'), 8 ],
    [ _('grade_9'), 9 ],
    [ _('grade_10'), 10 ],
    [ _('grade_11'), 11 ],
    [ _('grade_12'), 12 ],
    [ _('grade_13'), 13 ],
    [ _('grade_14'), 14 ],
    [ _('grade_15'), 15 ],
    [ _('grade_16'), 16 ],
    [ _('grade_t'), 90 ],
    [ _('grade_17'), 17 ]
  ].freeze    # freezeによって、この配列の値の変更を禁止する

  validates_presence_of :item_id, :f_name, :f_name_kana, :l_name, :l_name_kana, :l_name_initial, :age, :grade, :alias, :alias_kana, :sex

end
