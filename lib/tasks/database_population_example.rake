
namespace :db do
  
  desc "Erase all data and fill database with example data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Contact, Donation, Note, Number, Occasion, Presence, Task].each(&:delete_all)
    
    Contact.populate 40 do |contact|
      contact.first_name = Faker::Name.first_name
      contact.last_name = Faker::Name.last_name
      contact.spouse_name = Faker::Name.first_name
      contact.email = Faker::Name.first_name + "@example.com"
      contact.spouse_email = Faker::Name.first_name + "@example.com"
      contact.network = ['Please Choose', '168 Film Festival', 'AACF - Cal Poly Pomona', 'Bible Study Fellowship', 'Cal Poly Pomona', 
      'Calvary Chapel', 'Co-Worker', "Dillions International", 'Extended Faimly', 'First Church of God - Pomona', 'Friends of Friends',
      'Grace Brethen', 'Hesperia High School', 'Immediate Family', 'SIS: Ping Core', 'Missional Digerati Referrals', 'Mobile Ministry Forum',
      'Perspectives at Lake Avenue Church', 'Pragmatic Studios', 'Roommates', 'Ruby Meetup', 'San Gabriel Union Church and Christian School',
      'Strategicon Board Game Convention', 'US Center for World Mission', 'Other']
      contact.address_1 = Faker::Address.street_address
      contact.city = Faker::Address.city
      contact.state_id = 5
      contact.zip = Faker::Address.zip_code
      contact.country_id = 226
      contact.receive_newsletter = [true, false]
      contact.preferred_contact = ['Please Choose','Email', 'Letter', 'Twitter', 'Facebook', 'Call', 'In Person', 'Skype', 'FaceTime', 'Other']
      contact.created_at = 2.weeks.ago..Time.now
      contact.believer = [true, false]
      contact.donations_count = 3
      # contact.tags.name = "tags"
      
      Donation.populate 3 do |donation|
        donation.contact_id = contact.id
        donation.amount = [75.00, 100.25, 32.43]
        donation.project = ["Team Builder", "Developer network", "Design Work"]
        donation.donation_date = 1.weeks.ago.to_date..Time.now.to_date
      end
      
      Note.populate 1..3 do |note|
        note.contact_id = contact.id
        note.note = Faker::Lorem.sentence
      end
                
      Number.populate 1..2 do |number|
        number.contact_id = contact.id
        number.phone_type = ["Cell", "Fax", "Home", "Other"]
        number.number = Faker::PhoneNumber.phone_number
                  # number.created_at = 1.weeks.ago.to_date..Time.now.to_date
      end
                
      Occasion.populate 1..4 do |date|
        date.contact_id = contact.id
        date.occasion = ['Birthday', 'Party', 'Kids Birthday']
        date.special_date = Time.now.to_date..4.weeks.from_now.to_date
      end
                
      Presence.populate 2 do |web|
        web.contact_id = contact.id
        web.site = ["Facebook", "Twitter", "Tumblr", "Google +"]
        web.url = Faker::Internet.domain_name
        web.account = Faker::Internet.user_name
      end

      Task.populate 1..2 do |x|
        x.contact_id = contact.id
        x.completed = false
        x.task = ["Call", "Meeting", "Follow up", "Reminder"]
        x.due_date = Time.now.to_date
        x.category = ["Call", "Meeting", "Follow up", "Reminder"]
        x.created_at = Time.now
      end
      
    end

    contact = Contact.first
    contact.tasks.create({task: "overdue", due_date: 1.weeks.ago.to_date, category: "Phone Call"})
    contact.tasks.create({task: "1 week", due_date: 1.weeks.from_now.to_date, category: "Phone Call"})
    contact.tasks.create({task: "3 weeks", due_date: 3.weeks.from_now.to_date, category: "Phone Call"})

  end
end