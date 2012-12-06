Feature: A user should be able to manage their occasions that belong to users
	As a user 
	I want to be able to create, edit, update and delete occasions

	Scenario: A user should be able to add special dates to their contact
		Given there is a contact "The Doctor"
		And I am on the show page for "The Doctor"
		When I click the "Add Special Date" link
		And I fill in "occasion_special_date" with "19-11-2012"
		And I fill in "Occasion" with "birthday"
		And I click the "Create Occasion" button
		Then I should see "Your Occasion has been saved!"
		And I should be on the doctor's show page
		And I should see "birthday"
		And I should see "11/19/2012"
		
	Scenario: A user should be able to edit special dates that belong to their contacts.
		Given There is a contact "Edit occasions" and they have an occasion "birthday"
		And I am on the show page for "Edit occasions"
		And I should see "birthday"
		When I click on the "Edit" link for "birthday"
		And I fill in "occasion_special_date" with "3-11-2012"
		And I fill in "Occasion" with "halloween"
		And I click the "Update Occasion" button
		Then I should see "Your Occasion has ben updated."
		And I should be on the show page for "Edit occasions"
		And I should not see "birthday"
		And I should see "halloween"
		And I should see "11/03/2012"
		
	Scenario: A user should be able to delete special dates that belong to their contacts.
		Given There is a contact "Delete occasions" and they have an occasion "holiday"
		And I am on the show page for "Delete occasions"
		And I should see "holiday"
		When I click on the "Delete" link for "holiday"
		Then I should see "Your Occasion has been deleted."
		And I am on the show page for "Delete occasions"
		And I should not see "holiday"
		
	Scenario: A user should be able to add a special date for a contact through another contact
		Given given there are contacts "cup" and "mug"
		And I am on the show page for "Cup"
		When I click the "Add Special Date" link
		And I select "Mug" from "Contact"
		And I fill in "occasion_special_date" with "2-11-2012"
		And I fill in "Occasion" with "party"
		And I click the "Create Occasion" button
		Then I should see "Your Occasion has been saved!"
		And I should be on the show page for "Mug"
		And I should see "party"
		And I should see "11/02/2012"
		Then I am on the show page for "Cup"
		And I should not see "party"	
		
		

		
		