class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  def task_summary
    task_month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "due_date") 
    task_year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "due_date")
    @tasks_this_month = Task.where("#{task_month_strftime} = ? AND #{task_year_strftime} = ? AND completed = ?", Time.now.month.to_s, Time.now.year.to_s, false)
  end
  
  
end
