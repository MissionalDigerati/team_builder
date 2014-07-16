class Donation < ActiveRecord::Base
  belongs_to :contact, :counter_cache => true
  # before_validation :strip_amount
  validates :amount, :project, :contact_id, :presence => true
  validates :amount, :numericality => {:greater_than => 0}
  # scopes
  #
  scope :this_month_sum, -> {
    where("EXTRACT(MONTH FROM donation_date)::int = ? AND EXTRACT(YEAR FROM donation_date)::int = ?", Time.now.strftime("%m"), Time.now.strftime("%Y")).sum(:amount)
  }
  
  
  def self.average_donation
    Donation.where("amount > ?", 1).average(:amount).to_f
  end

  def self.monthly_sums(year)
    totals = [0,0,0,0,0,0,0,0,0,0,0,0]
    donations = Donation.select("SUM(amount) as total_donations, EXTRACT(MONTH FROM donation_date)::int as donate_month").where("EXTRACT(YEAR FROM donation_date)::int = ?", year).group('donate_month')
    donations.each do |donation|
      array_index = donation.donate_month-1
      totals[array_index] = donation.total_donations.round
    end
    totals
  end

  def self.yearly_sums
    totals = {}
    ten_years_ago = 10.years.ago.strftime("%Y")
    donations = Donation.select("SUM(amount) as total_donations, EXTRACT(YEAR FROM donation_date)::int as donate_year").where("EXTRACT(YEAR FROM donation_date)::int > #{ten_years_ago}").group('donate_year')
    donations.each do |donation|
      totals[donation.donate_year.to_s] = donation.total_donations.round
    end
    totals
  end
end