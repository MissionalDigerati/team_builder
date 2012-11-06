Given /^There is a contact "(.*?)" and they have a note "(.*?)"$/ do |name, note|
  FactoryGirl.create(:contact, first_name: name, email: name + '@gmail.com', state_id: 1, country_id: 1)
  FactoryGirl.create(:note, contact_id: Contact.where(first_name: name).first, note: note )
end
Then /^I should be on the new notes page for "(.*?)"$/ do |user_name|
  user = Contact.where(first_name: user_name).first
  current_path.should == new_contact_note_path(user)
end
