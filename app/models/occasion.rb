class Occasion < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :occasion, :contact_id, :special_date
end