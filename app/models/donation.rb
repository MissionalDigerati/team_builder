class Donation < ActiveRecord::Base
  belongs_to :contact, :counter_cache => true
  attr_accessible :date, :amount, :project, :contact_id, :donation_date
  # before_validation :strip_amount
  validates :amount, :project, :contact_id, :presence => true
  validates :amount, :numericality => {:greater_than => 0}
  
  def self.this_month_sum
    month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "donation_date") 
    year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "donation_date")
    Donation.where("#{month_strftime} = ? AND #{year_strftime} = ?", Time.now.strftime("%m"), Time.now.strftime("%Y")).sum(:amount)
  end
  
  def self.average_donation
    Donation.where("amount > ?", 1).average(:amount).to_f
  end

  def self.monthly_sums(year)
    totals = [0,0,0,0,0,0,0,0,0,0,0,0]
    month_strftime = DATE_MONTH_STRFTIME.gsub(/COLUMN/, "donation_date") 
    year_strftime = DATE_YEAR_STRFTIME.gsub(/COLUMN/, "donation_date")
    donations = Donation.select("SUM(amount) as total_donations, #{month_strftime} as donate_month").where("#{year_strftime} = ?", year).group(month_strftime)
    donations.each do |donation|
      array_index = donation.donate_month.to_i-1
      totals[array_index] = donation.total_donations.round
    end
    totals
  end
end