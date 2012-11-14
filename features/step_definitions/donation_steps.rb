Given /^There is a contact "(.*?)" and they have a donation "(.*?)"$/ do |name, donation|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "kirk@startrek.com", state_id: 1, country_id: 1)
  FactoryGirl.create(:donation, contact_id: Contact.where(first_name: name).first, donation_date: "2012-11-08", amount: "10.00", project: donation)
end
