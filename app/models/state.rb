class State < ActiveRecord::Base
  attr_accessible :state_long, :state_short
  has_many :contacts
end
