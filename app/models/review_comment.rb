class ReviewComment < ActiveRecord::Base
  belongs_to :review
  belongs_to :student

  validates_presence_of :content, :status
end
