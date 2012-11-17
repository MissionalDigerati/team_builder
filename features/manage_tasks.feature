Feature: A user should be able to create tasks for a user, edit, update, and create them for another user I should also be able to mark them as completed. 
	As a user with a contact
	I should be able to create multiple tasks, as well as edit and delete them.

	Scenario: A user should be able to add tasks to their contact
		Given there is a contact "Matt Smith"
		And I am on the show page for "Matt Smith"
		When I click the "Add Task" link
		And I fill in "Task" with "Get to the tardis"
		And I fill in "Due Date" with "06-11-2012"
		And I select "Call" from "Category"
		And I click the "Create Task" button
		Then I should see "Your Task has been saved!"
		And I should be on the show page for "Matt Smith"
		And I should see "Get to the tardis"
		And I should see "11/06/2012"
		
	Scenario: A user should be able to edit a task that already exists.
		Given There is a contact "edit task" and they have a task "build a fort"
		And I am on the show page for "edit task"
		When I click on the "Edit" link for "build a fort"
		And I fill in "Task" with "destroy a fort"
		And I fill in "Due Date" with "03-04-2012"
		And I select "Lunch" from "Category"
		And I click the "Update Task" button
		Then I should see "Your Task has been updated!"
		And I should be on the show page for "edit task"
		And I should see "destroy a fort"
		And I should see "04/03/2012"
		And I should not see "build a fort"
		
	Scenario: A user should be able to delete a task that already exists	
		Given There is a contact "delete task" and they have a task "throw a computer"
		And I am on the show page for "delete task"
		And I should see "throw a computer"
		When I click on the "Delete" link for "throw a computer"
		Then I should see "Your Task has been deleted."
		And I should be on the show page for "delete task"
		And I should not see "throw a computer"		

	Scenario: A user should be able to add a task for a contact through another contact
		Given given there are contacts "rose" and "martha"
		And I am on the show page for "rose"
		When I click the "Add Task" link
		And I select "martha" from "Contact"
		And I fill in "Task" with "destroy tardis"
		And I fill in "Due Date" with "1/2/201121"
		And I select "Lunch" from "Category"
		And I click the "Create Task" button
		Then I should see "Your Task has been saved!"
		And I should be on the show page for "martha"
		And I should see "destroy tardis"
		Then I am on the show page for "rose"
		And I should not see "destroy tardis"
		
	Scenario: A user should be able to mark a task as completed	
		Given There is a contact "mark task" and they have a task "buy a house"
		And I am on the show page for "mark task"
		When I click on the "Edit" link for "buy a house"
		And I check the checkbox for "Completed"
		And I click the "Update Task" button
		Then I should see "Your Task has been updated!"
		And I should be on the show page for "mark task"
		And I should not see "buy a house"

	Scenario: A user should be able to dynamically mark a task as completed	
		Given There is a contact "dynamic task" and they have a task "buy iphone"
		And I am on the show page for "dynamic task"
		And I should see "buy iphone"
		When I click on the "Mark as Completed" link for "buy iphone"
		Then I should not see "buy iphone"
		
		
	
	
	
	
	