class Task < ActiveRecord::Base
	
    belongs_to :contact
    attr_accessible :contact_id, :completed, :task, :due_date, :category
    validates :task, :due_date, :category, :contact_id, :presence => true

    CATEGORY = ["Call", "Email", "Follow Up", "Lunch", "Meeting", "Money Presentation", "Trip", "Other"]

    def self.total_tasks(type = nil)
        case type
            when :incomplete
                Task.where(completed: false).length
            when :completed
                Task.where(completed: true).length
            when :overdue
                Task.where("completed = ? AND due_date < ?", false, Date.today).length
            else
                Task.all.length
        end
    end

    #
    # The following methods are used in the application controller
    # They are called to query tasks that take place between defined dates
    def self.current_date
        Time.now.to_date	
    end

    def self.tomorrows_date
        1.days.from_now.to_date
    end

    def self.next_weeks_date
        1.weeks.from_now.to_date
    end

    def self.next_4_weeks_date
        4.weeks.from_now.to_date
    end

    def is_overdue?
        self.is_completed? ? false : self.due_date.to_datetime < DateTime.now
    end

    def is_completed?
        self.completed
    end

    #
    # The following methods are used in the application controller
    # They are used to help define what category occasions are to go in based on date

    def self.current_day_number
        Time.now.day
    end

    def self.current_month_number
        Time.now.month
    end

    def self.current_year
        Time.now.year.to_s
    end
	  
end