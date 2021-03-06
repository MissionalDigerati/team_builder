Feature: A user should be able to create, edit, and delete donations from their contacts; as well as create donations for other users.
	As a user with a contact
	I should be able to create multiple phone numbers, as well as edit and delete phone numbers.
	
	
	Scenario: A user should be able to add donation to their contact
		Given there is a contact "The Doctor"
		And I am on the show page for "The Doctor"
		When I click the "Add Donation" link
		And I fill in "date_select" with "10-11-2012"
		And I fill in "Amount" with "15.00"
		And I fill in "Project" with "Team builder"
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
		And I fill in "date_select" with "25-12-2012"
		And I fill in "Amount" with "35.00"
		And I fill in "Project" with "Starship enterprise"
		And I click the "Create Donation" button
		Then I should see "Your Donation has been saved!"
		And I should be on the show page for "scotty"
		And I should see "Starship enterprise"
		And I should see "12/25/2012"
		Then I am on the show page for "sulu"
		And I should not see "Starship enterprise"
		And I should not see "12/25/2012"
		
	Scenario: A user should be able to edit donations
		Given There is a contact "Edit donations contact" and they have a donation "the tardis"
		And I am on the show page for "Edit donations contact"
		And I should see "the tardis"
		When I click on the "Edit" link for "the tardis"
		And I fill in "date_select" with "25-12-2012"
		And I fill in "Amount" with "1000"
		And I fill in "Project" with "nothing"
		And I click the "Update Donation" button	
		Then I should see "Your Donation has been updated!"
		And I should not see "the tardis"	
		And I should see "nothing"
		And I should see "$1,000.00"
		And I should see "12/25/2012"
		
	Scenario: A user should be delete donations
		Given There is a contact "Delete donations contact" and they have a donation "tba"
		And I am on the show page for "Delete donations contact"
		And I should see "tba"
		When I click on the "Delete" link for "tba"
		Then I should see "Your Donation has been deleted."
		And I am on the show page for "Delete donations contact"
		And I should not see "tba"
		
	Scenario: A user should not be able to create a donation without all necessary info. 
		Given there is a contact "Donation error"
		And I am on the show page for "Donation error"
		When I click the "Add Donation" link
		And I click the "Create Donation" button
		Then I should see "Your Donation has not been saved"
	
	
	
	
	
	
	
		