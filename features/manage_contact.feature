Feature: A user manages their contacts
	As a user 
	I want to be able to manage and create a contact
	
	Scenario: A user should be able to add a contact
		Given I am on the home page
		And I click the "Create New Contact" link
		Then I should be on the add contact page
		When I fill in "first_name" with "Steve"
		And I fill in "last_name" with "Balmer"
		And I fill in "spouse_name" with "nancy"
		And I fill in "email" with "steve@microsoft.com"
		And I fill in "spouse_email" with "nancy@microsoft.com"
		And I fill in "address_1" with "123 fake street"
		And I fill in "address_2" with "apt 103"		
		And I fill in "city" with "san jose"
		And I fill in "state_id" with "california"
		And I fill in "zip" with "91801"				
		And I fill in "country_id" with "USA"
		And I fill in "Children" with "none"		
		And I select "Email" from "contact_preferred_contact"
		And I select "Roommates" from "contact_network"
		And I fill in "tags" with "none"
		And I check the "receive_newsletter" checkboxes
		And I click the "create_contact" button
		Then I should see "Contact was successfully created."
		
	Scenario: A user should be able to create a contact with multiple phone numbers, web presence, donations, and special dates on the same form. 	

		
		# 
		# <Contact id: nil, first_name: nil, last_name: nil, spouse_name: nil, 
		# email: nil, spouse_email: nil, tags: nil, network: nil, address_1: nil, 
		# address_2: nil, city: nil, state_id: nil, zip: nil, country_id: nil, 
		# receive_newsletter: false, children: nil, preferred_contact: nil, created_at: nil, updated_at: nil>