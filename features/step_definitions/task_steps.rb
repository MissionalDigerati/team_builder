Given /^There is a contact "(.*?)" and they have a task "(.*?)"$/ do |name, task|
  FactoryGirl.create(:contact, first_name: name, email: name + '@gmail.com')
  FactoryGirl.create(:task, contact_id: Contact.where(first_name: name).first, task: task, due_date: "1/2/1212", category: "Call" )
end

