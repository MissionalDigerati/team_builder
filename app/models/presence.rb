class Presence < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :site, :url, :account, :contact_id
  # validates :site, :url, :account, :contact_id, :presence => true
  SITES = ["Facebook", "Twitter", "Myspace", "Google +", "Tumblr", "Other"]
end
