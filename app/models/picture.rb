class Picture < ActiveRecord::Base
  validates_length_of :image, :within => 1024..16000000
  validates_format_of :content_type, :with =>/^image\/(p?jpeg|gif|(x-)?png)$/i
  validates_presence_of :name, :size, :content_type, :image
  
  belongs_to(:item)
#  belogns_to(:shopitem)
#  belogns_to(:student)
  
  def file
  end
  
  def file=(file)
    write_attribute(:name, file.original_filename)
    write_attribute(:size, file.length)
    write_attribute(:content_type, file.content_type.strip)
    write_attribute(:image, file.read)
  end
end
