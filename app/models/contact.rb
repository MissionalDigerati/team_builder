class Contact < ActiveRecord::Base
  belongs_to :state
  belongs_to :country

  has_many :numbers, :dependent => :destroy
  has_many :occasions
  has_many :donations
  has_many :tasks
  has_many :notes, :dependent => :destroy
  has_many :presences

  has_one :support_state

  attr_accessible :tag_list #acts as taggable gem
  acts_as_taggable
  
  attr_accessible :numbers_attributes
  attr_accessible :occasions_attributes
  attr_accessible :presences_attributes
  attr_accessible :support_state_attributes
  attr_accessible :first_name, :last_name, :spouse_name, :email, :spouse_email, :network, :address_1, :address_2, :city, 
  :state_id, :zip, :country_id, :receive_newsletter, :children, :preferred_contact, :believer, :spouse_believer, :presented_vision, :avatar, :account_number
  
  accepts_nested_attributes_for :numbers, :reject_if => lambda { |a| a[:number].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :occasions, :reject_if => lambda { |a| a[:occasion].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :presences, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :support_state
  
  validates :first_name, :last_name, :email, :presence => true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "115x115>" }, :default_url => "/images/missing/:style/missing.png"
  
  NETWORKS = ['168 Film Festival', 'AACF - Cal Poly Pomona', 'Bible Study Fellowship', 'Cal Poly Pomona', 
  'Calvary Chapel', 'Co-Worker', "Dillions International", 'Extended Faimly', 'First Church of God - Pomona', 'Friends of Friends',
  'Grace Brethen', 'Hesperia High School', 'Immediate Family', 'SIS: Ping Core', 'Missional Digerati Referrals', 'Mobile Ministry Forum',
  'Perspectives at Lake Avenue Church', 'Pragmatic Studios', 'Roommates', 'Ruby Meetup', 'San Gabriel Union Church and Christian School',
  'Strategicon Board Game Convention', 'US Center for World Mission', 'Other']
  
  CONTACTS = ['Email', 'Letter', 'Twitter', 'Facebook', 'Call', 'In Person', 'Skype', 'FaceTime', 'Other']

  def fullname
    fullname = "#{first_name} #{last_name}"
    fullname.present? ? fullname.titleize : ""
  end

  def family_name
    self.spouse_name.blank? ? self.fullname.titleize : "#{self.first_name} & #{self.spouse_name} #{self.last_name}".titleize
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

  #
  # The following is the logic behind the searching of contacts
  # via the search bar in the view. 

  def self.contact_search_and_tag_delegation(tag=nil, search=nil)
    if tag.present?
      self.tag_search(tag)
    elsif search.present?
      self.contact_search_delegation(search)
    end
  end

  def self.contact_search_delegation(search)
    if search.first == "#"
      self.tag_search(search)
    else
      self.contact_index(search)
    end
  end

  def self.contact_index(search)
    self.where("first_name like ? or last_name like ?", "%#{search}%", "%#{search}%")
  end

  def self.tag_search(tag)
    if tag.first == "#"
      tag.slice!(0)
    end
    self.tagged_with(tag)
  end

  def self.contact_report_query
    self.includes(:support_state).all
  end

end