class TasksController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :task_summary, :only => [:index]
  before_filter :set_task_variable, :only => [:edit, :update, :destroy, :completed]
  
  def index
    @task = Task.order(sort_column + " " + sort_direction).page(params[:page])
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
        flash[:notice] = @task.errors.empty? ? "Your Task has not been saved" : "Your Task has not been saved because: " + @task.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
  end
  
  def update
    @contact = Contact.find(@task.contact_id)
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Task has been updated!"
      else
        format.html {redirect_to action: "edit"}
        flash[:notice] = @task.errors.empty? ? "Your Task has not been saved" : "Your Task has not been saved because: " + @task.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @task.destroy
    respond_to do |format|
      format.html {redirect_to :back }
      flash[:notice] = "Your Task has been deleted."
    end
  end
  
  def completed
    # @contact = Contact.find(params[:contact_id])
    @task[:completed] = true
    respond_to do |format|
      if @task.save
        format.js
      end
    end
  end

  def set_task_variable
    @task = Task.find(params[:id])
  end
  
  protected
  
  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "completed"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end