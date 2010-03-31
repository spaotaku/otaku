class Message < ActiveRecord::Base

  validates_presence_of :priority, :title, :body, :org_name, :level

end
