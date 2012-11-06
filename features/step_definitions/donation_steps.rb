Given /^There is a contact "(.*?)" and they have a donation "(.*?)"$/ do |name, donation|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "kirk@startrek.com", tags: "Kirk", state_id: 1, country_id: 1)
  FactoryGirl.create(:donation, contact_id: Contact.where(first_name: name).first, date: "2/2/22", amount: "10.00", project: donation)
end
