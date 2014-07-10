class PresencesController < ApplicationController

  before_filter :set_presence_variable, :except => [:new, :create]
  
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
    @presence = @contact.presences.new(presence_params)
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
  end
  
  def update
    @contact = Contact.find(@presence.contact_id)
    respond_to do |format|
      if @presence.update_attributes(presence_params)
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Web Presence has been updated!"
      else
        format.html {redirect_to :back}
        flash[:notice] = @presence.errors.empty? ? "Your Web Presence has not been saved" : "Your Web Presence has not been saved because: " + @presence.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @presence.destroy
    respond_to do |format|
      format.html{redirect_to :back}
      flash[:notice] = "Your Web Presence has been deleted!"
    end
  end

  def set_presence_variable
    @presence = Presence.find(params[:id])
  end

  private

    def presence_params
      params.require(:presence).permit(:site, :url, :account, :contact_id)
    end
end