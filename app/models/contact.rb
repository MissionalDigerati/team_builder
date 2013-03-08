class Contact < ActiveRecord::Base
  belongs_to :state
  belongs_to :country

  has_many :numbers, :dependent => :destroy
  has_many :occasions
  has_many :donations
  has_many :tasks
  has_many :notes, :dependent => :destroy
  has_many :presences

  attr_accessible :tag_list #acts as taggable gem
  acts_as_taggable
  attr_accessible :numbers_attributes
  attr_accessible :occasions_attributes
  attr_accessible :presences_attributes
  attr_accessible :first_name, :last_name, :spouse_name, :email, :spouse_email, :network, :address_1, :address_2, :city, 
  :state_id, :zip, :country_id, :receive_newsletter, :children, :preferred_contact, :believer, :spouse_believer, :presented_vision
  
  accepts_nested_attributes_for :numbers, :reject_if => lambda { |a| a[:number].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :occasions, :reject_if => lambda { |a| a[:occasion].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :presences, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true
  
  validates :first_name, :last_name, :email, :presence => true
  
  NETWORKS = ['168 Film Festival', 'AACF - Cal Poly Pomona', 'Bible Study Fellowship', 'Cal Poly Pomona', 
  'Calvary Chapel', 'Co-Worker', "Dillions International", 'Extended Faimly', 'First Church of God - Pomona', 'Friends of Friends',
  'Grace Brethen', 'Hesperia High School', 'Immediate Family', 'SIS: Ping Core', 'Missional Digerati Referrals', 'Mobile Ministry Forum',
  'Perspectives at Lake Avenue Church', 'Pragmatic Studios', 'Roommates', 'Ruby Meetup', 'San Gabriel Union Church and Christian School',
  'Strategicon Board Game Convention', 'US Center for World Mission', 'Other']
  
  CONTACTS = ['Email', 'Letter', 'Twitter', 'Facebook', 'Call', 'In Person', 'Skype', 'FaceTime', 'Other']

  def fullname
    "#{first_name} #{last_name}"
  end
  
  def self.non_believers
    Contact.where("believer = ?", false).length
  end
  
  def self.contact_count
    Contact.all.length
  end
  
  def self.donated_contacts
    Contact.where("donations_count > ?", 0).length
  end

	def self.who_saw_presentation
    Contact.where("presented_vision = ?", true).length
  end
  
  def self.contacts_in_last_month
    Contact.find(:all, :conditions => ["created_at between ? and ?", 4.weeks.ago.to_date, Time.now.to_date]).length
  end
  
  def self.contacts_in_last_year
    Contact.find(:all, :conditions => ["created_at between ? and ?", 1.years.ago.to_date, Time.now.to_date]).length
  end

  def self.contact_index(tag, search)
    if tag.present?
      tag_search(tag)
    else
      self.where("first_name like ? or last_name like ?", "%#{search}%", "%#{search}%")
    end
  end

  def self.tag_search(tag)
    if tag.first == "#"
      tag.slice!(0)
    end
    self.tagged_with(tag)
  end


end