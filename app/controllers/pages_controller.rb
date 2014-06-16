class PagesController < ApplicationController
	
  before_filter :occasion_summary, :task_summary, :only => [:home]
  
  def home
    @task = Task.where(:completed => false).order("due_date DESC")
  end

end