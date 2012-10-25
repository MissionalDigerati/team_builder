class DonationsController < ApplicationController
  
  def new
    @contact = Contact.find(params[:contact_id])
    @donations = @contact.donations.build
  end
  
  def create
    @contact = Contact.find(params[:donation][:contact_id])
    @donations = @contact.donations.new(params[:donation])
    respond_to do |format|
      if @donations.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Donation has been saved!"
      else
        format.html {render action: "new"}
        flash[:notice] = "Your Donation has not been saved"
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @donations = @contact.donations.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:contact_id])
    @donations = @contact.donations.find(params[:id])
    respond_to do |format|
      if @donations.update_attributes(params[:donation])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Donation has been updated!"
      else
        format.html {render action: "edit"}
        flash[:notice] = "Your Donation has not been updated"
      end
    end
  end
  
  def destroy
     @donations = Donation.find(params[:id])
     @donations.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       flash[:notice] = "Your Donation has been deleted."
     end
   end
  
end


