class TasksController < ApplicationController
  
  def new
    @contact = Contact.find(params[:contact_id])
    @task = @contact.tasks.build
  end
  
  def create
    @contact = Contact.find(params[:contact_id])
    @task = @contact.tasks.new(params[:task])
    respond_to do |format|
      if @task.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Task has been saved!"
      else
        format.html {redirect_to :action => "new"}
        flash[:notice] = "Your Task has not been saved!"
      end
    end
  end
  
end
