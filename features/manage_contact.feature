Feature: A user manages their contacts
	As a user 
	I want to be able to manage and create a contact
	
	Scenario: A user should be able to add a contact
		Given I am on the home page
		And I click the "New Contact" link
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
		And I check the "receive_newsletter" checkboxes
		And I click the "create_contact" button
		Then I should see "Contact was successfully created."
		
	Scenario: A user should be able to create a contact phone numbers, web presence, and special dates on the same form. 	
		Given I am on the home page
		And I click the "New Contact" link
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
		And I check the "receive_newsletter" checkboxes
		And I select "Home" from "Phone Type"
		And I fill in "Phone Number" with "7777777"
		And I fill in "contact_occasions_attributes_0_special_date" with "01-11-2012"
		And I fill in "Occasion" with "new years"
		And I select "Facebook" from "Site"
		And I fill in "URL" with "www.facebook.com"
		And I fill in "Account" with "facebook filler"
		And I click the "create_contact" button
		Then I should see "Contact was successfully created."
		And I should see "7777777"
		And I should see "new years"
		And I should see "Facebook"
		
	Scenario: Contacts should be searchable by tags
		Given there is a contact named "Amy" with tag friend
		And I am on the home page
		And I click the "New Contact" link
		When I fill in "first_name" with "Starbucks"
		And I fill in "last_name" with "Cafe"
		And I fill in "email" with "Starbucks@coffee.com"
		And I fill in "contact_tag_list" with "friend, coffee"
		And I click the "create_contact" button
		Then I should see "Contact was successfully created."
		When I click the "coffee" link
		Then I should see "Searching by tag: Coffee"
		And I should see "Starbucks"
		And I should not see "Amy"
		When I click the "friend" link
		Then I should see "Starbucks"
		And I should see "Searching by tag: Friend"
		And I should see "Amy"
		When I click the "doctor" link
		And I should see "Searching by tag: Doctor"
		And I should see "Amy"
		And I should not see "Starbucks"
	
  Scenario: tags should be searchable via searchbar when query is prefixed with #
  	Given there is a contact named "bill" with tag friend
  	And there is a contact named "ted" with tag friend
  	And I am on the home page
  	When I fill in "search" with "#friend"
  	And I click the "search_submit" button
  	Then I should be on the contact index page
  	And I should see "Bill"
		And I should see "Ted"
  	And I should see "Searching by tag: Friend"
  	When I fill in "search" with "#enemy"
  	And I click the "search_submit" button
  	Then I should be on the contact index page
  	And I should see "Searching by tag: Enemy"	
		And I should not see "Bill"
		And I should not see "Ted"
	
	Scenario: contacts should be searchable via searchbar
		Given there is a contact named "River" with tag friend
		And there is a contact "who"
		And I am on the home page
		When I fill in "search" with "river"
		And I click the "search_submit" button
		Then I should be on the contact index page
		And I should see "River"
		And I should see "Searching for: River"
		And I should not see "Who"
		When I fill in "search" with "who"
		And I click the "search_submit" button
		Then I should be on the contact index page
		And I should see "Who"
		And I should see "Searching for: Who"
		
		# 
		# <Contact id: nil, first_name: nil, last_name: nil, spouse_name: nil, 
		# email: nil, spouse_email: nil, tags: nil, network: nil, address_1: nil, 
		# address_2: nil, city: nil, state_id: nil, zip: nil, country_id: nil, 
		# receive_newsletter: false, children: nil, preferred_contact: nil, created_at: nil, updated_at: nil>