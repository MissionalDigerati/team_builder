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
  FactoryGirl.create(:contact, first_name: first_name, last_name: "unknown", spouse_name: "River", email: "Thedoctor@who.com", spouse_email: "River@who.com", state_id: 1, country_id: 1)
end
When /^I click on the "(.*?)" link for "(.*?)"$/ do |link, title|
  within(:xpath, "//table/tr[contains(.,'#{title}')]") do
    click_link link
  end
end
Then /^I should not see "(.*?)"$/ do |text|
  page.should_not have_content text
end
When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end
Given /^given there are contacts "(.*?)" and "(.*?)"$/ do |first_user, second_user|
  FactoryGirl.create(:contact, first_name: first_user, email: first_user + "@fakeemail.com", state_id: 1, country_id: 1)
  FactoryGirl.create(:contact, first_name: second_user, email: second_user + "@fakeemail.com", state_id: 1, country_id: 1)
end
Then /^I should be on the show page for "(.*?)"$/ do |user_name|
  user = Contact.where(first_name: user_name).first
  current_path.should == contact_path(user)
end

 # <!-- => #<Contact id: nil, first_name: nil, last_name: nil, spouse_name: nil, email: nil, 
 # spouse_email: nil, tags: nil, network: nil, address_1: nil, address_2: nil, city: nil, 
 # state_id: nil, zip: nil, country_id: nil, receive_newsletter: false, children: nil, 
 # preferred_contact: nil, created_at: nil, updated_at: nil>  -->