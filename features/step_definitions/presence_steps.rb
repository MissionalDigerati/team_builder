Given /^There is a contact "(.*?)" and they have a web presence "(.*?)"$/ do |name, presence|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "kirk@startrek.com", tags: "Kirk")
  FactoryGirl.create(:presence, contact_id: Contact.where(first_name: name).first, site: "Facebook", url: "testing", account: presence)
end