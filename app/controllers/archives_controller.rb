class ArchivesController < ApplicationController
  def index
    @archives = Archives.all
  end
  
  def create
    @contact = Contact.new()

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Archive was sucessfully created.' }
      else
        format.html { render action: "index" }
        flash[:notice] = @archive.errors.empty? ? "Your Archive has not been saved" : "Your Archive has not been saved because: " + @archive.errors.full_messages.to_sentence
      end
    end
  end 
end