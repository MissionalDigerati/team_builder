class Task < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :contact_id, :completed, :task, :due_date, :category
  validates :task, :due_date, :category, :contact_id, :presence => true
  
  CATEGORY = ["Call", "Email", "Follow Up", "Lunch", "Meeting", "Money Presentation", "Trip", "Other"]
  
  def self.incomplete_tasks
    tasks = Task.where(:completed => false)
    tasks.length
  end
  
end
