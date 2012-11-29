class OccasionsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :occasion_summary, :only => [:index]
  
  def index
    # @occasions = Occasion.order("updated_at DESC").page(params[:page])
    @occasions = Occasion.order(sort_column + " " + sort_direction).page(params[:page])
  end
  
  def new
    if params[:contact_id] == nil
      @occasions = Occasion.new
    else
      @contact = Contact.find(params[:contact_id])
      @occasions = @contact.occasions.build
    end
  end
  
  def create
    @contact = Contact.find(params[:occasion][:contact_id])
    @occasions = @contact.occasions.new(params[:occasion])
    respond_to do |format|
      if @occasions.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Occasion has been saved!"
      else
        format.html {render action: "new"}
        flash[:notice] = @occasions.errors.empty? ? "Your Occasion has not been saved" : "Your Occasion has not been saved because: " + @occasions.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @occasions = @contact.occasions.find(params[:id])
  end
   
  def update
    @occasions = Occasion.find(params[:id])
    @contact = Contact.find(@occasions.contact_id)
    respond_to do |format|
      if @occasions.update_attributes(params[:occasion])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Occasion has ben updated."
      else
        format.html {render action: "edit"}
        flash[:notice] = @occasions.errors.empty? ? "Your Occasion has not been saved" : "Your Occasion has not been saved because: " + @occasions.errors.full_messages.to_sentence
      end
    end
  end
  
   
  def destroy
     @occasions = Occasion.find(params[:id])
     @occasions.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       flash[:notice] = "Your Occasion has been deleted."
     end
   end
   
   protected
   
   def sort_column
     Occasion.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
   end
  
end
