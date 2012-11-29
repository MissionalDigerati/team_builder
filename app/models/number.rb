class Number < ActiveRecord::Base
  attr_accessible :phone_type, :number, :contact_id
  belongs_to :contact
  before_save :phone_number_strip
  
  # validates :number, :phone_type, :presence => true
  
  TYPES = ["Mobile", "Home", "Work", "Fax", "Skype", "Other", "Unknown"]
  # attr_accessible :title, :body
  
  def phone_number_strip
    striped = self.number.gsub(/[^0-9,]|,[0-9]*$/,'')
    self.number = striped
  end
  
end
