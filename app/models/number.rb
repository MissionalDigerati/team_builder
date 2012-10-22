class Number < ActiveRecord::Base
  attr_accessible :phone_type, :number
  belongs_to :contact
  
  validates :number, :presence => true
  
  TYPES = ["Mobile", "Home", "Work", "Fax", "Skype", "Other"]
  # attr_accessible :title, :body
end
