class TasksController < ApplicationController
  
  
  def index
    @task = Task.order("completed ASC").page(params[:page])
  end
  
  def new
    if params[:contact_id] == nil
      @task = Task.new
    else
      @contact = Contact.find(params[:contact_id])
      @task = @contact.tasks.build
    end
  end
  
  def create
    @contact = Contact.find(params[:task][:contact_id])
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
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @contact = Contact.find(@task.contact_id)
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Task has been updated!"
      else
        format.html {redirect_to action: "edit"}
        flash[:notice] = "Your Task has not been updated."
      end
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html {redirect_to :back }
      flash[:notice] = "Your Task has been deleted."
    end
  end
  
  def completed
    @task = Task.find(params[:id])
    # @contact = Contact.find(params[:contact_id])
    @task[:completed] = true
    respond_to do |format|
      if @task.save
        format.js
      end
    end
  end
  
end
