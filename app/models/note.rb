class Note < ActiveRecord::Base
  belongs_to :contact
  validates :contact_id, :note, :presence => true
end