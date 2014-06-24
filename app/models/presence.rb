class Presence < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :site, :url, :account, :contact_id
  SITES = [
    "Behance", "Blogger", "deviantART", "Digg", "Dribbble", "Dropbox", "Facebook", "Flickr", "Google Plus", 
    "Instagram", "LinkedIn", "Myspace", "PayPal", "Pinterest", "RSS Feed", "Skype", "StumbleUpon", "Tumblr", 
    "Twitter", "Vimeo", "Website", "WordPress", "Yahoo", "Youtube", "Other"
  ]
end