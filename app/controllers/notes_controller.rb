class NotesController < ApplicationController
  
  def new
    @contact = Contact.find(params[:contact_id])
    @note = @contact.notes.build
  end
  
  
  def create  
    @contact = Contact.find(params[:note][:contact_id])
    @note = @contact.notes.new(params[:note])
    respond_to do |format|
      if @note.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Note has been saved!"
      else
        format.html {redirect_to :back}
        flash[:notice] = "Your Note has not been saved."
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @note = @contact.notes.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:contact_id])
    @note = @contact.notes.find(params[:id])
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html{redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Note has been updated!"
      else
        format.html{redirect_to :back}
        flash[:notice] = "Your Note has not been updated."
      end
    end
  end
  
  def destroy
    @contact = Contact.find(params[:contact_id])
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.html{redirect_to :back}
      flash[:notice] = "Your Note has been deleted!"
    end
  end
  
end
