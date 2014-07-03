class Number < ActiveRecord::Base
  belongs_to :contact
  before_save :phone_number_strip
  
  # validates :number, :phone_type, :presence => true
  
  TYPES = ["Mobile", "Home", "Work", "Fax", "Skype", "Other", "Unknown"]
  # attr_accessible :title, :body
  
  #this is called as a before save, this strips the entered phone numbers of anything other than numeric symbol
  #there is a view helper which displays them as a phonenumber. 
  def phone_number_strip
    striped = self.number.gsub(/[^0-9,]|,[0-9]*$/,'')
    self.number = striped
  end
end