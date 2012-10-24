class NumbersController < ApplicationController
  
  def new
    @contact = Contact.find(params[:contact_id])
    @number = @contact.numbers.build
  end
  
  def create
    @contact = Contact.find(params[:contact_id])
    @number = @contact.numbers.new(params[:number])
    respond_to do |format|
      if @number.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your number has been saved!"
      else
        format.html {render action: "new"}
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @number = @contact.numbers.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:contact_id])
    @number = @contact.numbers.find(params[:id])
    respond_to do |format|
      if @number.update_attributes(params[:number])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your phone number has been updated."
      else
        format.html {render action: "edit"}
        flash[:notice] = "Your phone number was not updated."
      end
    end
  end
  
  def destroy
     @number = Number.find(params[:id])
     @number.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       format.json { head :no_content }
     end
   end
  
end
