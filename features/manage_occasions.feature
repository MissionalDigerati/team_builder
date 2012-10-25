Feature: A user should be able to manage their occasions that belong to users
	As a user 
	I want to be able to create, edit, update and delete occasions

	Scenario: A user should be able to add special dates to their contact
		Given there is a contact "The Doctor"
		And I am on the show page for "The Doctor"
		When I click the "Add Special Date" link
		And I select "Jan" from "Month"
		And I select "12" from "Day"
		And I select "2012" from "Year"
		And I fill in "Occasion" with "birthday"
		And I click the "Create Occasion" button
		Then I should see "Your Occasion has been saved!"
		And I should be on the doctor's show page
		And I should see "birthday"
		
	Scenario: A user should be able to edit special dates that belong to their contacts.
		Given There is a contact "edit occasions" and they have an occasion "birthday"
		And I am on the show page for "edit occasions"
		And I should see "birthday"
		When I click on the "Edit" link for "birthday"
		And I fill in "Occasion" with "halloween"
		And I click the "Update Occasion" button
		Then I should see "Your Occasion has ben updated."
		And I should be on the show page for "edit occasions"
		And I should not see "birthday"
		And I should see "halloween"
		
	Scenario: A user should be able to delete special dates that belong to their contacts.
		Given There is a contact "delete occasions" and they have an occasion "holiday"
		And I am on the show page for "delete occasions"
		And I should see "holiday"
		When I click on the "Delete" link for "holiday"
		Then I should see "Your Occasion has been deleted."
		And I am on the show page for "delete occasions"
		And I should not see "holiday"