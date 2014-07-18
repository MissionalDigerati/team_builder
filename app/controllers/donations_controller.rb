class DonationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    if params[:month] && params[:year]
      @donations = Donation.where(["EXTRACT(MONTH FROM donation_date)::int = ? AND EXTRACT(YEAR FROM donation_date)::int = ?", params[:month], params[:year]]).page(params[:page]).order("donation_date DESC")
    elsif params[:year]
      @donations = Donation.where(["EXTRACT(YEAR FROM donation_date)::int = ?",params[:year]]).page(params[:page]).order("donation_date DESC")
    else
      @donations = Donation.order(sort_column + " " + sort_direction).page(params[:page])
    end
  end
  
  def new
    if params[:contact_id] == nil
      @donation = Donation.new
    else
      @contact = Contact.find(params[:contact_id])
      @donation = @contact.donations.build
    end
  end
  
  def create
    @contact = Contact.find(params[:donation][:contact_id])
    @donation = @contact.donations.new(donation_params)
    respond_to do |format|
      if @donation.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Donation has been saved!"
      else
        format.html {render action: "new"}
        flash[:notice] = @donation.errors.empty? ? "Your Donation has not been saved" : "Your Donation has not been saved because: " + @donation.errors.full_messages.to_sentence
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @donation = @contact.donations.find(params[:id])
    @donation.amount = "%.2f" % @donation.amount
  end
  
  def update
    @donation = Donation.find(params[:id])
    @contact = Contact.find(@donation.contact_id)
    respond_to do |format|
      if @donation.update_attributes(donation_params)
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Donation has been updated!"
      else
        format.html {render action: "edit"}
        flash[:notice] = @donation.errors.empty? ? "Your Donation has not been updated" : "Your Donation has not been updated because: " + @donation.errors.full_messages.to_sentence
      end
    end
  end
  
  def destroy
     @donation = Donation.find(params[:id])
     @donation.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       flash[:notice] = "Your Donation has been deleted."
     end
   end
  
  protected
  
    def sort_column
      Donation.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
    end

  private

    def donation_params
      params.require(:donation).permit(:amount, :contact_id, :donation_date, :project)
    end
  
end


