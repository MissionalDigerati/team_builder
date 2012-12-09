class PresencesController < ApplicationController
  
  def new
    if params[:contact_id] == nil
      @presence = Presence.new
    else
      @contact = Contact.find(params[:contact_id])
      @presence = @contact.presences.build
    end
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
        flash[:notice] = @presence.errors.empty? ? "Your Web Presence has not been saved" : "Your Web Presence has not been saved because: " + @presence.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @presence = Presence.find(params[:id])
  end
  
  def update
    @presence = Presence.find(params[:id])
    @contact = Contact.find(@presence.contact_id)
    respond_to do |format|
      if @presence.update_attributes(params[:presence])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Web Presence has been updated!"
      else
        format.html {redirect_to :back}
        flash[:notice] = @presence.errors.empty? ? "Your Web Presence has not been saved" : "Your Web Presence has not been saved because: " + @presence.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @presence = Presence.find(params[:id])
    @presence.destroy
    respond_to do |format|
      format.html{redirect_to :back}
      flash[:notice] = "Your Web Presence has been deleted!"
    end
  end
end