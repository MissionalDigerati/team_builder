class NumbersController < ApplicationController
  def new
    @contact = Contact.find(params[:contact_id])
    @number = @contact.numbers.build
  end
end
