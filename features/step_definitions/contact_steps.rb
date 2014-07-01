When /^I click the "(.*?)" link$/ do |link_title|
  click_on link_title
end
Then /^I should be on the add contact page$/ do
  expect(page.current_path).to eq(new_contact_path)
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
  expect(page.current_path).to eq(contact_path(thedoctor))
end
Given /^there is a contact named "(.*?)" with tag friend$/ do |name|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", spouse_name: "none", email: "amypond@fakeemail.com", state_id: 1, country_id: 1, tag_list: "friend, doctor")
end
# adding phone numbers
