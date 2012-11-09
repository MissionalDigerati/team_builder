class Donation < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :date, :amount, :project, :contact_id, :donation_date
  
  validates :amount, :project, :contact_id, :presence => true
  
  
  def self.this_month_sum
    month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "donation_date") 
    year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "donation_date")
    donation_month = Donation.where("#{month_strftime} = ? AND #{year_strftime} = ?", Time.now.month.to_s, Time.now.year.to_s).sum(:amount)
  end
  
end
