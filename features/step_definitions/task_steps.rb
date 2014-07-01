Given /^There is a contact "(.*?)" and they have a task "(.*?)"$/ do |name, task|
  FactoryGirl.create(:contact, first_name: name, last_name: "unknown", email: name + '@gmail.com', state_id: 1, country_id: 1)
  FactoryGirl.create(:task, contact_id: Contact.where(first_name: name).first.id, task: task, due_date: "1/2/1212", category: "Call" )
end
When /^I check the checkbox for "(.*?)"$/ do |checkbox|
  check(checkbox)
end

When /^I check the completed checkbox for "(.*?)"$/ do |task_title|
  task_to_complete = Task.where(task: task_title).first
  check("mark-complete-task-#{task_to_complete.id}")
end