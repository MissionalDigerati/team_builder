Given /^There is a contact "(.*?)" and they have a phone number "(.*?)"$/ do |name, number|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "kirk@startrek.com", tags: "Kirk")
  FactoryGirl.create(:number, contact_id: Contact.where(first_name: name).first, number: number, phone_type: "Mobile")
end