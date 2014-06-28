class ApplicationController < ActionController::Base
    protect_from_forgery

    private

    #
    # Used for searchable columns in a verity of controllers / views
    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    #
    # This method is set up as a before filter for the home page in the pages controller. 
    # This passes the info to make the tables for the left had side bar to display upcoming task info
    # all of the variables that define the dates in these queries, are located in the Task.rb model / file
    def task_summary
        @tasks_within_week_range = Task.find(:all, :order => "due_date ASC", :conditions => ["due_date between ? and ? AND completed = ?", Task.tomorrows_date, Task.next_weeks_date, false])
        @tasks_this_month = Task.find(:all, :order => "due_date ASC", :conditions => ["due_date between ? and ? AND completed = ?", Task.next_weeks_date, Task.next_4_weeks_date, false])
        @tasks_overdue = Task.find(:all, :order => "due_date ASC", :conditions => ["due_date < ? AND completed = ?", Task.current_date, false])
    end

    def occasion_summary
        order_by_strftime = DATE_MONTH_DAY_ORDER_STRFTIME.gsub(/COLUMN/, "special_date").gsub(/DIRECTION/, "ASC")
        today = Date.today
        @occasions_week = Occasion.find_special_dates_for(today, today + 8.days).order(order_by_strftime)
    end

end