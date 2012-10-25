class Donation < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :date, :amount, :project, :contact_id
  
  validates :amount, :project, :presence => true
  
end
