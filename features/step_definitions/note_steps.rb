Given /^There is a contact "(.*?)" and they have a note "(.*?)"$/ do |name, note|
  FactoryGirl.create(:contact, first_name: name, email: name + '@gmail.com')
  FactoryGirl.create(:note, contact_id: Contact.where(first_name: name).first, note: note )
end

