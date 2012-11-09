class Occasion < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :day, :month, :year, :occasion, :contact_id
  # validates :day, :month, :occasion, :contact_id, :presence => true
  
  year = Time.new.year
  
  DAYS = Array(1..31)
  MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]
  YEARS = [year, year + 1, year + 2, year + 3]
  
  def self.special_date(day, month, year)
    if year.present?
      date = day + ' / ' + month + ' / ' + year
    else
      date = day + ' / ' + month
    end
  end
  
end
