class OccasionsController < ApplicationController
  
  def new
    @contact = Contact.find(params[:contact_id])
    @occasions = @contact.occasions.build
  end
  
  def create
    @contact = Contact.find(params[:contact_id])
    @occasions = @contact.occasions.new(params[:occasion])
    respond_to do |format|
      if @occasions.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Occasion has been saved!"
      else
        format.html {render action: "new"}
        flash[:notice] = "Your Occasion has not been saved"
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @occasions = @contact.occasions.find(params[:id])
  end
   
  def update
    @contact = Contact.find(params[:contact_id])
    @occasions = @contact.occasions.find(params[:id])
    respond_to do |format|
      if @occasions.update_attributes(params[:occasion])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Occasion has ben updated."
      else
        format.html {render action: "edit"}
        flash[:notice] = "Your Occasion could not be saved."
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
  
end
