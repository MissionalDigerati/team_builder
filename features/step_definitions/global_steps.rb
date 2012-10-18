Given /^I am on the home page$/ do
  visit root_path
end
When /^I click the "(.*?)" button$/ do |button|
  click_on button
end
Then /^I should see "(.*?)"$/ do |text|
  page.should have_content text
end
Given /^there is a contact "(.*?)"$/ do |first_name|
  FactoryGirl.create(:contact, first_name: first_name, last_name: "unknown", spouse_name: "River", email: "Thedoctor@who.com", spouse_email: "River@who.com", tags: "The Doctor")
end

 # <!-- => #<Contact id: nil, first_name: nil, last_name: nil, spouse_name: nil, email: nil, 
 # spouse_email: nil, tags: nil, network: nil, address_1: nil, address_2: nil, city: nil, 
 # state_id: nil, zip: nil, country_id: nil, receive_newsletter: false, children: nil, 
 # preferred_contact: nil, created_at: nil, updated_at: nil>  -->