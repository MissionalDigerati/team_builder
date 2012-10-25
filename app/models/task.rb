class Task < ActiveRecord::Base
  belongs_to :contact
  # attr_accessible :title, :body
end
