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
		And I select "California" from "contact_state_id"
		And I fill in "spouse_email" with "nancy@microsoft.com"
		And I fill in "address_1" with "123 fake street"
		And I fill in "address_2" with "apt 103"		
		And I fill in "city" with "san jose"
		And I fill in "zip" with "91801"				
		And I fill in "Children" with "none"		
		And I select "Email" from "contact_preferred_contact"
		And I select "Roommates" from "contact_network"
		And I fill in "tags" with "none"
		And I check the "receive_newsletter" checkboxes
		And I click the "create_contact" button
		Then I should see "Contact was successfully created."
		
	Scenario: A user should be able to create a contact phone numbers, web presence, and special dates on the same form. 	
		Given I am on the home page
		And I click the "Create New Contact" link
		Then I should be on the add contact page
		When I fill in "first_name" with "Jeff"
		And I fill in "last_name" with "Bridges"
		And I fill in "spouse_name" with "nancy"
		And I fill in "email" with "jeff@thedude.com"
		And I fill in "address_1" with "123 la street"	
		And I fill in "city" with "los angeles"
		And I select "California" from "contact_state_id"
		And I fill in "zip" with "91801"				
		And I select "United States" from "contact_country_id"
		And I fill in "Children" with "none"		
		And I select "Email" from "contact_preferred_contact"
		And I select "Roommates" from "contact_network"
		And I fill in "tags" with "none"
		And I check the "receive_newsletter" checkboxes
		And I select "Home" from "Phone Type"
		And I fill in "Phone Number" with "7777777"
		And I select "Jan" from "Month"
		And I select "1" from "Day"
		And I select "2012" from "Year"
		And I fill in "Occasion" with "new years"
		And I select "Facebook" from "Site"
		And I fill in "URL" with "www.facebook.com"
		And I fill in "Account" with "facebook filler"
		And I click the "create_contact" button
		Then I should see "Contact was successfully created."
		And I should see "7777777"
		And I should see "new years"
		And I should see "Facebook"
		
		# 
		# <Contact id: nil, first_name: nil, last_name: nil, spouse_name: nil, 
		# email: nil, spouse_email: nil, tags: nil, network: nil, address_1: nil, 
		# address_2: nil, city: nil, state_id: nil, zip: nil, country_id: nil, 
		# receive_newsletter: false, children: nil, preferred_contact: nil, created_at: nil, updated_at: nil>