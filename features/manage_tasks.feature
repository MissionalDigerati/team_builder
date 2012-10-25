Feature: A user should be able to create tasks for a user, edit, update, and create them for another user I should also be able to mark them as completed. 
	As a user with a contact
	I should be able to create multiple tasks, as well as edit and delete them.

	Scenario: A user should be able to add tasks to their contact
		Given there is a contact "Matt Smith"
		And I am on the show page for "Matt Smith"
		When I click the "Add Task" link
		And I fill in "Task" with "Get to the tardis"
		And I fill in "due_date" with "1/2/201121"
		And I select "Call" from "Category"
		And I click the "Create Task" button
		Then I should see "Your Task has been saved!"
		And I should be on the show page for "Matt Smith"
		And I should see "Get to the tardis"
		And I should see "1/2/201121"