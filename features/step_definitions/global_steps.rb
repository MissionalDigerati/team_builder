Given /^I am on the home page$/ do
  visit root_path
end
When /^I click the "(.*?)" button$/ do |button|
  click_on button
end
Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
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
  expect(page).to_not have_content(text)
end
When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end
Given /^given there are contacts "(.*?)" and "(.*?)"$/ do |first_user, second_user|
  FactoryGirl.create(:contact, first_name: first_user, last_name: "first_user", email: first_user + "@fakeemail.com", state_id: 1, country_id: 1)
  FactoryGirl.create(:contact, first_name: second_user, last_name: "second_user", email: second_user + "@fakeemail.com", state_id: 1, country_id: 1)
end
Then /^I should be on the show page for "(.*?)"$/ do |user_name|
  user = Contact.where(first_name: user_name).first
  current_path.should == contact_path(user)
end
Then /^I should be on the contact index page$/ do
  expect(current_path).to eq(contacts_path)
end
When /^I submit the form "(.*?)"$/ do |element|
  page.execute_script("$('#search').submit()")
end