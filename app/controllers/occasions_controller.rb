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
      @occasions = Occasion.new
    else
      @contact = Contact.find(params[:contact_id])
      @occasions = @contact.occasions.build
    end
  end
  
  def create
    @contact = Contact.find(params[:occasion][:contact_id])
    @occasions = @contact.occasions.new(occasion_params)
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
      if @occasions.update_attributes(occasion_params)
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

  private

    def occasion_params
      params.require(:occasion).permit(:occasion, :contact_id, :special_date)
    end
  
end
