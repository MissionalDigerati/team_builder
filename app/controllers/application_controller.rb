class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  #
  # This method is set up as a before filter for the home page in the pages controller. 
  # This passes the info to make the tables for the left had side bar to display upcoming task info
  def task_summary
    today = Time.now.to_date
    tomorrow = 1.days.from_now.to_date
    next_week = 1.weeks.from_now.to_date
    next_4_weeks = 4.weeks.from_now.to_date

    @tasks_within_week_range = Task.find(:all, :order => "due_date ASC", :conditions => ["due_date between ? and ? AND completed = ?", tomorrow, next_week, false])
    @tasks_this_month = Task.find(:all, :order => "due_date ASC", :conditions => ["due_date between ? and ? AND completed = ?", next_week, next_4_weeks, false])
    @tasks_overdue = Task.find(:all, :order => "due_date ASC", :conditions => ["due_date < ? AND completed = ?", today, false])
  end
  
  def occasion_summary
    task_day_strftime = DATE_DAY_STRFTIME.gsub(/COLUMN/, "special_date") 
    task_month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "special_date") 
    task_year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "special_date")
    day = Time.now.day
    month = Time.now.month
    year = Time.now.year.to_s
    @occasions_today = Occasion.where(["#{task_day_strftime} + 0 = ? AND #{task_month_strftime} + 0 = ?", day, month])
    @occasions_week = Occasion.find(:all, :conditions => ["#{task_day_strftime} + 0 between ? and ? AND #{task_month_strftime} + 0 = ?", day + 1, day + 5, month], :order => "special_date")
    @occasions_month = Occasion.where("#{task_month_strftime} + 0 = ? AND #{task_day_strftime} + 0 > ?", month, day).order("special_date")
  end
  
end