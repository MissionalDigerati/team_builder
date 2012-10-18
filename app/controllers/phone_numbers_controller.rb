class PhoneNumbersController < ApplicationController
  
  def new
    @phone_number = @contact.phone_number.new
  end
  
  def create
    @phone_number = @contact.phone_number.new(params[:phone_number])
    respond_to do |format|
      if @phone_number.save
        format.html {redirect_to :back, notice: "Your phone number has been saved!"}
      else
        format.html {redirect_to :back, notice: "Your phone number has not been saved."}
      end
    end
  end


end
