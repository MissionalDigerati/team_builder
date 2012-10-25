class Number < ActiveRecord::Base
  attr_accessible :phone_type, :number
  belongs_to :contact
  
  validates :number, :phone_type, :presence => true
  
  TYPES = ["Mobile", "Home", "Work", "Fax", "Skype", "Other", "Unknown"]
  # attr_accessible :title, :body
end
