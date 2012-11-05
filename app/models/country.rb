class Country < ActiveRecord::Base
  attr_accessible :iso, :iso3, :name, :numcode, :printable_name
  has_many :contacts
end
