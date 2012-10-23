class Occasion < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :day, :month, :year, :occasion
  
  year = Time.new.year
  
  DAYS = Array(1..31)
  MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]
  YEARS = [year, year + 1, year + 2, year + 3]
end
