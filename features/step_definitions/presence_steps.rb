Given /^There is a contact "(.*?)" and they have a web presence "(.*?)"$/ do |name, presence|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "kirk@startrek.com", state_id: 1, country_id: 1)
  FactoryGirl.create(:presence, contact_id: Contact.where(first_name: name).first.id, site: "Facebook", url: "testing", account: presence)
end