class DonationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    donation_year = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "donation_date")
    donation_month = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "donation_date")
    if params[:month] && params[:year]
      @donations = Donation.where(["#{donation_month} + 0 = ? AND #{donation_year} = ?", params[:month], params[:year]]).page(params[:page]).order("donation_date")
    elsif params[:year]
      @donations = Donation.where(["#{donation_year} = ?",params[:year]]).page(params[:page]).order("donation_date")
    else
      @donations = Donation.order(sort_column + " " + sort_direction).page(params[:page])
    end
  end
  
  def new
    if params[:contact_id] == nil
      @donations = Donation.new
    else
      @contact = Contact.find(params[:contact_id])
      @donations = @contact.donations.build
    end
  end
  
  def create
    @contact = Contact.find(params[:donation][:contact_id])
    @donations = @contact.donations.new(params[:donation])
    respond_to do |format|
      if @donations.save
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Donation has been saved!"
      else
        format.html {render action: "new"}
        flash[:notice] = "Your Donation has not been saved"
      end
    end
  end
  
  def edit
    @contact = Contact.find(params[:contact_id])
    @donations = @contact.donations.find(params[:id])
  end
  
  def update
    @donations = Donation.find(params[:id])
    @contact = Contact.find(@donations.contact_id)
    respond_to do |format|
      if @donations.update_attributes(params[:donation])
        format.html {redirect_to(contact_path(@contact))}
        flash[:notice] = "Your Donation has been updated!"
      else
        format.html {render action: "edit"}
        flash[:notice] = "Your Donation has not been updated"
      end
    end
  end
  
  def destroy
     @donations = Donation.find(params[:id])
     @donations.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       flash[:notice] = "Your Donation has been deleted."
     end
   end
  
  protected
  
  def sort_column
    Donation.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
  end
  
end


