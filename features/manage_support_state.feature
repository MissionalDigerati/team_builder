Feature: A user should be able to create, edit, and delete web presences from their contacts
	As a user 
	I should be able to update contacts support statvia their contact page for through forms. 
	
	@javascript
	Scenario: A user should be able to manage their contacts
		Given there is a contact "support state buttons" with a support state
		And I am on the show page for "support state buttons"
		When I click the "Initial State" link
		Then I should see "Support state has been updated to Initial State."
		When I click the "Contacting" link
		Then I should see "Support state has been updated to Contacting."
		When I click the "Seen Presentation" link
		Then I should see "Support state has been updated to Seen Presentation."
		When I click the "Following Up" link
		Then I should see "Support state has been updated to Following Up."
		When I click the "No Response" link
		Then I should see "Support state has been updated to No Response."
		When I click the "Not Giving" link
		Then I should see "Support state has been updated to Not Giving."
		When I click the "One Time Gift" link
		Then I should see "Support state has been updated to One Time Gift."
		When I click the "Monthly Gift" link
		Then I should see "Support state has been updated to Monthly Gift."

	Scenario: A user should be able to manually edit their contacts support state
		Given there is a contact "support_state_update" with a support state
		And I am on the show page for "support_state_update"
		When I click the "Edit Donation Status" link
		And I click the "Update Support state" link
		Then I should be on the show page for "support_state_update"
		And I should see "Support state has been updated!"
