class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  def task_summary
    # if Time.now.day < 10
    #      day = "0" + Time.now.day.to_s
    #    else
    #      day = Time.now.day.to_s
    #    end  
    # Time.now.day < 10 ? day = "0" + Time.now.day.to_s : day = Time.now.day.to_s  
    day = Time.now.day
    week_range = day + 7
    month = Time.now.month.to_s
    year = Time.now.year.to_s
    task_day_strftime = DATE_DAY_STRFTIME.gsub(/COLUMN/, "due_date") 
    task_month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "due_date") 
    task_year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "due_date")
    # ModelA.dates.where('start >= ? OR end <= ?', week_start, week_end)
    # @events = Event.find(:all, :conditions => ["start_date between ? and ?", date.Today, date.next_month.beginning_of_month])
    @tasks_within_week_range = Task.find(:all, :conditions => ["#{task_day_strftime} + 0 between ? and ? AND #{task_month_strftime} = ? AND #{task_year_strftime} = ? AND completed = ?", day, week_range, month, year, false])
    # @tasks_today = Task.where("#{task_day_strftime} + 0 = ? AND #{task_month_strftime} = ? AND #{task_year_strftime} = ? AND completed = ?", day, month, year, false)
    @tasks_this_month = Task.where("#{task_month_strftime} = ? AND #{task_year_strftime} = ? AND completed = ?", month, year, false)
    
  end
  
  
end
