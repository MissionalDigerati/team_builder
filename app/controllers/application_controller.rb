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
    task_day_strftime = DATE_DAY_STRFTIME.gsub(/COLUMN/, "special_date") 
    task_month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "special_date") 
    # task_year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "special_date")
    @occasions_today = Occasion.where(["#{task_day_strftime} + 0 = ? AND #{task_month_strftime} + 0 = ?", Task.current_day_number, Task.current_month_number])
    @occasions_week = Occasion.find(:all, :conditions => ["#{task_day_strftime} + 0 between ? and ? AND #{task_month_strftime} + 0 = ?", Task.current_day_number + 1, Task.current_day_number + 5, Task.current_month_number], :order => "special_date")
    @occasions_month = Occasion.where("#{task_month_strftime} + 0 = ? AND #{task_day_strftime} + 0 > ?", Task.current_month_number, Task.current_day_number).order("special_date")
  end
  
end