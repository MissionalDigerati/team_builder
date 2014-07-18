class OccasionsController < ApplicationController
  
  before_filter :occasion_summary, :only => [:index]
  
  def index
    if params[:start].present? && params[:end].present?
        start_date = Date.parse(params[:start])
        end_date = Date.parse(params[:end])
        @reoccuring_occasions = Occasion.find_special_dates_for(start_date, end_date)
    end
  end
  
  def new
    if params[:contact_id] == nil
      @occasion = Occasion.new
    else
      @contact = Contact.find(params[:contact_id])
      @occasion = @contact.occasions.build
    end
  end
  
  def create
    @contact = Contact.find(params[:occasion][:contact_id])
    @occasion = @contact.occasions.new(occasion_params)
    respond_to do |format|
      if @occasion.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your special date has been saved!"
      else
        format.html {render action: "new"}
        flash[:notice] = @occasions.errors.empty? ? "Your special date has not been saved" : "Your special date has not been saved because: " + @occasions.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @occasion = @contact.occasions.find(params[:id])
  end
   
  def update
    @occasion = Occasion.find(params[:id])
    @contact = Contact.find(@occasion.contact_id)
    respond_to do |format|
      if @occasion.update_attributes(occasion_params)
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Occasion has ben updated."
      else
        format.html {render action: "edit"}
        flash[:notice] = @occasions.errors.empty? ? "Your special date has not been saved" : "Your special date has not been saved because: " + @occasions.errors.full_messages.to_sentence
      end
    end
  end
  
   
  def destroy
     @occasion = Occasion.find(params[:id])
     @occasion.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       flash[:notice] = "Your special date has been deleted."
     end
   end

  private

    def occasion_params
      params.require(:occasion).permit(:occasion, :contact_id, :special_date)
    end
  
end
