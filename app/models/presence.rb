class Presence < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :site, :url, :account
  SITES = ["Facebook", "Twitter", "Myspace", "Google +", "Tumblr", "Other"]
end
