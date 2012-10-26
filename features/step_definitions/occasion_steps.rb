Given /^There is a contact "(.*?)" and they have an occasion "(.*?)"$/ do |name, occasion|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "kirk@startrek.com", tags: "Kirk")
  FactoryGirl.create(:occasion, contact_id: Contact.where(first_name: name).first, day: "31", month: "10", year: "2012", occasion: occasion)
end