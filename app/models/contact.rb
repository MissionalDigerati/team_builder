class Contact < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :spouse_name, :email, :spouse_email, :tags, :network, :address_1, :address_2, :city, :state_id, :zip, :country_id, :receive_newsletter, :children, :preferred_contact
  has_many :numbers, :dependent => :destroy
  has_many :occasions
  has_many :donations
  has_many :tasks
  has_many :notes, :dependent => :destroy
  has_many :presences
  validates :first_name, :email, :presence => true
  
  
  NETWORKS = ['Please Choose', '168 Film Festival', 'AACF - Cal Poly Pomona', 'Bible Study Fellowship', 'Cal Poly Pomona', 
  'Calvary Chapel', 'Co-Worker', "Dillions International", 'Extended Faimly', 'First Church of God - Pomona', 'Friends of Friends',
  'Grace Brethen', 'Hesperia High School', 'Immediate Family', 'SIS: Ping Core', 'Missional Digerati Referrals', 'Mobile Ministry Forum',
  'Perspectives at Lake Avenue Church', 'Pragmatic Studios', 'Roommates', 'Ruby Meetup', 'San Gabriel Union Church and Christian School',
  'Strategicon Board Game Convention', 'US Center for World Mission', 'Other']
  
  CONTACTS = ['Please Choose','Email', 'Letter', 'Twitter', 'Facebook', 'Call', 'In Person', 'Skype', 'FaceTime', 'Other']

  def news_letter(arg)
    if arg === true
      "Yes"
    else
      "No"
    end
  end
  

  
end
#<Contact id: nil, first_name: nil, last_name: nil, spouse_name: nil, 
# email: nil, spouse_email: nil, tags: nil, network: nil, address_1: nil, 
# address_2: nil, city: nil, state_id: nil, zip: nil, country_id: nil, 
# receive_newsletter: false, children: nil, preferred_contact: nil, created_at: nil, updated_at: nil> 