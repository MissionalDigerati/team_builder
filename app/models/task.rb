class Task < ActiveRecord::Base
	
    belongs_to :contact
    validates :task, :due_date, :category, :contact_id, :presence => true

    CATEGORY = ["Call", "Email", "Follow Up", "Lunch", "Meeting", "Money Presentation", "Trip", "Other"]

    # scopes
    #
    scope :one_week_from_today, -> { where(completed: false, due_date: Date.today..1.weeks.from_now.to_date).order("due_date ASC") }
    scope :one_month_from_today, -> { where(completed: false, due_date: Date.today..1.month.from_now.to_date).order("due_date ASC") }
    scope :overdue, -> { where(["due_date < ? AND completed = ?", Date.today, false]).order("due_date ASC") }

    def self.total_tasks(type = nil)
        case type
            when :incomplete
                Task.where(completed: false).length
            when :completed
                Task.where(completed: true).length
            when :overdue
                Task.overdue.count
            else
                Task.all.length
        end
    end

    def is_overdue?
        self.is_completed? ? false : self.due_date.to_datetime < DateTime.now
    end

    def is_completed?
        self.completed
    end
	  
end