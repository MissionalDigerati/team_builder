class Occasion < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :occasion, :contact_id, :special_date
  
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
