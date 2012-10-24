class DonationsController < ApplicationController
  
  def new
    @contact = Contact.find(params[:contact_id])
    @donations = @contact.donations.build
    @all_contacts = Contact.find(:all, :order => "last_name")
    puts "candy"
    puts @all_contacts
  end
  
  def create
    @contact = Contact.find(params[:contact_id])
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
  
  def destroy
     @donations = Donation.find(params[:id])
     @donations.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       format.json { head :no_content }
     end
   end
  
end
