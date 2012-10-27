class PresencesController < ApplicationController
  
  def new
    @contact = Contact.find(params[:contact_id])
    @presence = @contact.presences.build
  end
  
  def create
    @contact = Contact.find(params[:presence][:contact_id])
    @presence = @contact.presences.new(params[:presence])
    respond_to do |format|
      if @presence.save 
        format.html{redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Web Presence has been saved!"
      else
        format.html{redirect_to :back}
        flash[:notice] = "Your web presence has not been saved."
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @presence = Presence.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:contact_id])
    @presence = Presence.find(params[:id])
    respond_to do |format|
      if @presence.update_attributes(params[:presence])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Web Presence has been updated!"
      else
        format.html {redirect_to :back}
        flash[:notice] = "Your web presence has not been updated."
      end
    end
  end
  
  def destroy
    @contact = Contact.find(params[:contact_id])
    @presence = Presence.find(params[:id])
    @presence.destroy
    respond_to do |format|
      format.html{redirect_to :back}
      flash[:notice] = "Your Web Presence has been deleted!"
    end
  end
  
end
