class Note < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :note, :contact_id
  validates :contact_id, :note, :presence => true
end