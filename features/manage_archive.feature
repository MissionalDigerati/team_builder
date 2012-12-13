Feature: A user should be able to back up their database through the app. 
	As a user with several contacts,
	I should be able to back them up to a yml file. 
	
	@archive
	Scenario: A user should be able to back up their data
		Given there is a contact "Sponge bob"
		And I am on the show page for "Sponge bob"
		When I click the "Backup" link
		Then I should be on the archive page
		When I click the "Create Backup" link
		Then I should be on the archive page
		And I should see "Archive was successfully created."
		
	Scenario: A user should be able to delete their back up data 
		Given there is a backup "fred.tgz"
		And I am on the home page
		When I click the "Backup" link
		Then I should be on the archive page
		And I should see "fred.tgz"
		When I click on the "Delete" link for "fred.tgz"
		Then I should be on the archive page
		And I should see "Unable to locate file, however it's record has beed deleted."
		And I should not see "fred.tgz"