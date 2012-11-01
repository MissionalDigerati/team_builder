class PagesController < ApplicationController
  def home
    @task = Task.where(:completed => false).limit(10)
  end
  
end
