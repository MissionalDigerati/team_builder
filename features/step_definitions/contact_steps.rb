When /^I click the "(.*?)" link$/ do |link_title|
  click_on link_title
end
Then /^I should be on the add contact page$/ do
  page.current_path.should == new_contact_path
end
When /^I fill in "(.*?)" with "(.*?)"$/ do |form_name, form_content|
  fill_in form_name, with: form_content
end
When /^I select "(.*?)" from "(.*?)"$/ do |value, dropdown|
  # save_and_open_page
  select(value, :from => dropdown)
end
When /^I check the "(.*?)" checkboxes$/ do |checkbox_id|
  check(checkbox_id)
end
Given /^I am on the show page for "(.*?)"$/ do |first_name|
  contact = Contact.where(first_name: first_name).first
  visit contact_path(contact)
end
Then /^I should be on the doctor's show page$/ do
  thedoctor = Contact.where(first_name: "The Doctor").first
  page.current_path.should == contact_path(thedoctor)
end

# adding phone numbers
