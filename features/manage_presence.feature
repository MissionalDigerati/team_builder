Feature: A user should be able to create, edit, and delete web presences from their contacts
	As a user with a contact
	I should be able to create multiple web presence(s) for contacts, as well as edit and delete them. 
	
	Scenario: A user should be able to add a web presence to their contact
		Given there is a contact "Add Presence"
		And I am on the show page for "Add Presence"
		When I click the "Add Web Presence" link
		And I select "Facebook" from "Site"
		And I fill in "URL" with "www.facebook.com"
		And I fill in "Account" with "filler"
		And I click the "Create Presence" button
		Then I should see "Your Web Presence has been saved!"
		And I should be on the show page for "Add Presence"
		And I should see "Facebook"
		And I should see "www.facebook.com"
		And I should see "filler"
		
	Scenario: A user should be able to edit an existing web presence
		Given There is a contact "edit presence" and they have a web presence "testing"
		And I am on the show page for "edit presence"
		And I should see "testing"
		And I should see "Facebook"
		When I click on the "Edit" link for "testing"
		And I select "Twitter" from "Site"
		And I fill in "URL" with "www.twitter.com"
		And I fill in "Account" with "Twitter Account"
		And I click the "Update Presence" button
	  Then I should see "Your Web Presence has been updated!"
		And I should see "Twitter"
		And I should see "www.twitter.com"