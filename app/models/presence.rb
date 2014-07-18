class Presence < ActiveRecord::Base
  belongs_to :contact
  before_validation :smart_add_url_protocol

  SITES = [
    "Behance", "Blogger", "deviantART", "Digg", "Dribbble", "Dropbox", "Facebook", "Flickr", "Google Plus", 
    "Instagram", "LinkedIn", "Myspace", "PayPal", "Pinterest", "RSS Feed", "Skype", "StumbleUpon", "Tumblr", 
    "Twitter", "Vimeo", "Website", "WordPress", "Yahoo", "Youtube", "Other"
  ]

  protected

    def smart_add_url_protocol
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
        self.url = "http://#{self.url}"
      end
    end
end