class NotesController < ApplicationController

  before_filter :set_not_variable, :only => [:update, :destroy]
  
  def new
    if params[:contact_id] == nil
      @note = Note.new
    else
      @contact = Contact.find(params[:contact_id])
      @note = @contact.notes.build
    end
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
        flash[:notice] = @note.errors.empty? ? "Your Note has not been saved" : "Your Note has not been saved because: " + @note.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @note = @contact.notes.find(params[:id])
  end
  
  def update
    @contact = Contact.find(@note.contact_id)
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html{redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Note has been updated!"
      else
        format.html{redirect_to :back}
        flash[:notice] = @note.errors.empty? ? "Your Note has not been updated" : "Your Note has not been updated because: " + @note.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
    @contact = Contact.find(params[:contact_id])
    @note.destroy
    respond_to do |format|
      format.html{redirect_to :back}
      flash[:notice] = "Your Note has been deleted!"
    end
  end

  def set_not_variable
    @note = Note.find(params[:id])
  end
  
end
