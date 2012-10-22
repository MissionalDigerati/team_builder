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
  
end
