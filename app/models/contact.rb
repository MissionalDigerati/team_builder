class Contact < ActiveRecord::Base
  belongs_to :state
  belongs_to :country

  has_many :numbers, :dependent => :destroy
  has_many :occasions, :dependent => :destroy
  has_many :donations
  has_many :tasks, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :presences, :dependent => :destroy

  has_one :support_state

  acts_as_taggable
  
  accepts_nested_attributes_for :numbers, :reject_if => lambda { |a| a[:number].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :occasions, :reject_if => lambda { |a| a[:occasion].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :presences, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true

  validates :first_name, :last_name, :email, :presence => true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "115x115>" }, :default_url => "/images/missing/:style/missing.png"

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]

  # AASM State machine settings
  #
  include AASM

  aasm column: :team_status do
    state :pending, initial: true
    state :sent_letter
    state :setting_up_a_meeting
    state :presented_vision
    state :following_up

    # These states are 100%
    #
    state :no_response
    state :cannot_give
    state :special_gift
    state :monthly_supporter
  end
  
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

  def invite_to_team_percent
    case self.team_status.to_sym
      when :no_response, :cannot_give, :special_gift, :monthly_supporter
        100
      when :following_up
        80
      when :presented_vision
        60
      when :setting_up_a_meeting
        40
      when :sent_letter
        20
      else
        0
    end
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
    Contact.where(["created_at between ? and ?", 4.weeks.ago.to_date, Time.now.to_date]).length
  end
  
  def self.contacts_in_last_year
    Contact.where(["created_at between ? and ?", 1.years.ago.to_date, Time.now.to_date]).length
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

  def update_team_status(status)
    if self.aasm.states.map(&:name).include?(status)
      self.team_status = status
      self.team_status_updated_on = Date.today
      self.presented_vision = true if status == :presented_vision
      self.sent_letter = true if status == :sent_letter
      self.save
    else
      false
    end
  end

  def self.team_status_total(status = nil)
    if self.aasm.states.map(&:name).include?(status)
      self.where(team_status: status).length
    else
      self.all.length
    end
  end

end