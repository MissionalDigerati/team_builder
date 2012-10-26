class Task < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :contact_id, :completed, :task, :due_date, :category
  validates :task, :due_date, :category, :presence => true
  
  CATEGORY = ["Call", "Email", "Follow Up", "Lunch", "Meeting", "Money Presentation", "Trip", "Other"]
  
end
