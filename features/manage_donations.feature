Feature: A user should be able to create, edit, and delete donations from their contacts; as well as create donations for other users.
	As a user with a contact
	I should be able to create multiple phone numbers, as well as edit and delete phone numbers.
	
	
	Scenario: A user should be able to add donation to their contact
		Given there is a contact "The Doctor"
		And I am on the show page for "The Doctor"
		When I click the "Add Donation" link
		And I fill in "donation_date" with "10-11-2012"
		And I fill in "amount" with "15.00"
		And I fill in "project" with "Team builder"
		And I click the "Create Donation" button
		Then I should see "Your Donation has been saved!"
		And I should be on the doctor's show page
		And I should see "Team builder"
		And I should see "11/10/2012"
		
	# This ensures that the user can add a donation to any contact regardless of what user's id created the donations form. 
	Scenario: A user should be able to add a donation for a contact through another contact
		Given given there are contacts "sulu" and "scotty"
		And I am on the show page for "sulu"
		When I click the "Add Donation" link
		And I select "scotty" from "Contact"
		And I fill in "donation_date" with "25-12-2012"
		And I fill in "amount" with "35.00"
		And I fill in "project" with "Starship enterprise"
		And I click the "Create Donation" button
		Then I should see "Your Donation has been saved!"
		And I should be on the show page for "scotty"
		And I should see "Starship enterprise"
		And I should see "12/25/2012"
		Then I am on the show page for "sulu"
		And I should not see "Starship enterprise"
		And I should not see "12/25/2012"
		
	Scenario: A user should be able to edit donations
		Given There is a contact "Joey Needs to Edit Donation" and they have a donation "the tardis"
		And I am on the show page for "Joey Needs to Edit Donation"
		And I should see "The tardis"
		When I click on the "donation" "edit" link under the action selector for "the tardis"
		And I fill in "donation_date" with "25-12-2012"
		And I fill in "amount" with "1000"
		And I fill in "project" with "nothing"
		And I click the "Update Donation" button	
		Then I should see "Your Donation has been updated!"
		And I should not see "The tardis"	
		And I should see "Nothing"
		And I should see "$1,000.00"
		And I should see "12/25/2012"
		
	Scenario: A user should be delete donations
		Given There is a contact "Joey Needs to Delete Donation" and they have a donation "tba"
		And I am on the show page for "Joey Needs to Delete Donation"
		And I should see "Tba"
		When I click on the "donation" "delete" link under the action selector for "tba"
		Then I should see "Your Donation has been deleted."
		And I am on the show page for "Joey Needs to Delete Donation"
		And I should not see "Tba"
		
	Scenario: A user should not be able to create a donation without all necessary info. 
		Given there is a contact "Donation error"
		And I am on the show page for "Donation error"
		When I click the "Add Donation" link
		And I click the "Create Donation" button
		Then I should see "Your Donation has not been saved"
	
	
	
	
	
	
	
		