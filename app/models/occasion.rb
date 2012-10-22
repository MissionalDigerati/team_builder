class Occasion < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :day, :month, :year, :occasion
  
  DAYS = Array(1..31)
  MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]
  YEARS = ["2012", "2013", "2014", "2015"]
end
