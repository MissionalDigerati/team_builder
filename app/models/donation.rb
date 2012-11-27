class Donation < ActiveRecord::Base
  belongs_to :contact, :counter_cache => true
  attr_accessible :date, :amount, :project, :contact_id, :donation_date
  validates :amount, :project, :contact_id, :presence => true
  
  
  def self.month_hash
    {"Jan" => 1, "Feb" => 2}
  end
  
  def self.this_month_sum
    month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "donation_date") 
    year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "donation_date")
    donation_month = Donation.where("#{month_strftime} = ? AND #{year_strftime} = ?", Time.now.month.to_s, Time.now.year.to_s).sum(:amount)
  end
  
  def self.average_donation
    average_donation = Donation.where("amount > ?", 1).average(:amount).to_f
    # number_to_currency(average_donation)
    # number_to_currency(average, :precision => 2)
  end
  
end
