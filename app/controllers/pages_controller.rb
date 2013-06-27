class PagesController < ApplicationController
	
  before_filter :occasion_summary, :only => [:home]
  
  def home
    @task = Task.where(:completed => false).limit(10)
  end

end