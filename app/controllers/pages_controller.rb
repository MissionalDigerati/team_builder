class PagesController < ApplicationController
  before_filter :task_summary, :only => [:home]
  def home
    @task = Task.where(:completed => false).limit(10)
  end
  
end
