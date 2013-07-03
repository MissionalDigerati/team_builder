class NumbersController < ApplicationController

  before_filter :set_number_var, :only => [:update, :destroy]
  
  def new
    if params[:contact_id] == nil
      @number = Number.new
    else
      @contact = Contact.find(params[:contact_id])
      @number = @contact.numbers.build
    end
  end
  
  def create
    @contact = Contact.find(params[:number][:contact_id])
    @number = @contact.numbers.new(params[:number])
    respond_to do |format|
      if @number.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your number has been saved!"
      else
        format.html {render action: "new"}
        flash[:notice] = @number.errors.empty? ? "Your Phone Number has not been saved" : "Your Phone Number has not been saved because: " + @number.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @number = @contact.numbers.find(params[:id])
  end
  
  def update
    @contact = Contact.find(@number.contact_id)
    respond_to do |format|
      if @number.update_attributes(params[:number])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your phone number has been updated."
      else
        format.html {render action: "edit"}
        flash[:notice] = @number.errors.empty? ? "Your Phone Number has not been saved" : "Your Phone Number has not been saved because: " + @number.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
     @number.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       flash[:notice] = "Your phone number has been deleted."
     end
   end
  
  def set_number_var
    @number = Number.find(params[:id])
  end

end
