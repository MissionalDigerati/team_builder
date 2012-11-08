class Donation < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :date, :amount, :project, :contact_id, :donation_date
  
  validates :amount, :project, :contact_id, :presence => true
  
  time = Time.now
  month = time.month
  year = time.year
  
  def donations_this_month
    
  end
  
end
