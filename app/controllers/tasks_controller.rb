class TasksController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :set_task_variable, :only => [:edit, :update, :destroy, :completed]
  
  def index
    # Do not worry, we are verifying these are only the fields we allow
    #
    if sort_column.empty? && sort_direction.empty?
        sort_order = "completed ASC, due_date DESC"
    else
        sort_order = sort_column + " " + sort_direction
    end
    case params[:filter_type]
        when "incomplete"
            @tasks = Task.where(completed: false).order(sort_order).page(params[:page])
            @widget_title = "Incomplete Tasks (Check to Complete)"
        when "completed"
            @tasks = Task.where(completed: true).order(sort_order).page(params[:page])
            @widget_title = "Completed Tasks"
        when "overdue"
            @tasks = Task.where("completed = ? AND due_date < ?", false, Date.today).order(sort_order).page(params[:page])
            @widget_title = "Overdue Tasks (Check to Complete)"
        else
            @tasks = Task.order(sort_order).page(params[:page])
            @widget_title = "All Tasks (Check to Complete)"
    end
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
    Task.column_names.include?(params[:sort]) ? params[:sort] : ""
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : ""
  end
  
end