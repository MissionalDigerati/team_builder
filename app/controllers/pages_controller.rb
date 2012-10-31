class PagesController < ApplicationController
  def home
    @task = Task.find(:all, :limit => 10)
  end
  
end
