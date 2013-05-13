Given /^there is a contact "(.*?)" with a support state$/ do |first_name|
  contact = FactoryGirl.create(:contact, first_name: first_name, last_name: "unknown", spouse_name: "River", email: "Thedoctor@who.com", spouse_email: "River@who.com", state_id: 1, country_id: 1)  	
  FactoryGirl.create(:defaulted_support_state, contact_id: contact.id)
end
