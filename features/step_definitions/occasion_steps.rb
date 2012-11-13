Given /^There is a contact "(.*?)" and they have an occasion "(.*?)"$/ do |name, occasion|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "kirk@startrek.com", tags: "Kirk", state_id: 1, country_id: 1)
  FactoryGirl.create(:occasion, contact_id: Contact.where(first_name: name).first, special_date: "19-11-2012", occasion: occasion)
end
Then /^I should be on the new occasion page for "(.*?)"$/ do |user_name|
  user = Contact.where(first_name: user_name).first
  current_path.should == new_contact_occasion_path(user)
end