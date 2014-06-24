class PagesController < ApplicationController
	
  before_filter :occasion_summary, :task_summary, :only => [:home]
  
  def home
    @tasks = Task.where(:completed => false).order("due_date ASC")
  end

end