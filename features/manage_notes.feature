Feature: A user should be able to create, edit, and delete notes from their contacts; as well as create notes for other users.
	As a user with a contact
	I should be able to create multiple notes, as well as edit and delete notes.
	
	Scenario: A user should be able to add a note to their contact
		Given there is a contact "Hamlet"
		And I am on the show page for "Hamlet"
		When I click the "Add Note" link
		And I fill in "Note" with "Once more into the breach dear friends."
		And I click the "Create Note" button
		Then I should see "Your Note has been saved!"
		And I should be on the show page for "Hamlet"
		And I should see "Once more into the breach dear friends."
		
	Scenario: A user should be able to edit an existing note 
		Given There is a contact "edit note" and they have a note "what what in the"
		And I am on the show page for "edit note"
		And I should see "what what in the"
		When I click on the "Edit" link for "what what in the"
		And I fill in "Note" with "Samwell is the best"
		And I click the "Update Note" button
		Then I should see "Your Note has been updated!"
		And I should be on the show page for "edit note"
		And I should see "Samwell is the best"
		And I should not see "what what in the"
		
	Scenario: A user should be able to delete an existing note
		Given There is a contact "delete note" and they have a note "This note will be deleted"
		And I am on the show page for "delete note"
		And I should see "This note will be deleted"
		When I click on the "Delete" link for "This note will be deleted"
		Then I should see "Your Note has been deleted!"
		And I should be on the show page for "delete note"
		And I should not see "This note will be deleted"
		
	Scenario: A user should be able to add a note for a contact through another contact
		Given given there are contacts "cheese" and "cake"
		And I am on the show page for "cheese"
		When I click the "Add Note" link
		And I select "cake" from "Contact"
		And I fill in "Note" with "pumpkin pie is better than cheesecake"
		And I click the "Create Note" button
		Then I should see "Your Note has been saved!"
		And I should be on the show page for "cake"
		And I should see "pumpkin pie is better than cheesecake"
		Then I am on the show page for "cheese"
		And I should not see "pumpkin pie is better than cheesecake"
		
	Scenario: A user should not be able to create a note without all necessary info. 
		Given there is a contact "error note"
		And I am on the show page for "error note"
		When I click the "Add Note" link
		And I click the "Create Note" button
		Then I should see "Your Note has not been saved."
			