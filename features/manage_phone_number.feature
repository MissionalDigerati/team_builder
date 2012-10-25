Feature: A user should be able to edit and create phone numbers for their contacts
	As a user with a contact
	I should be able to create multiple phone numbers, as well as edit and delete phone numbers.
	
	Scenario: A user should be able to add multiple phone numbers to a contact
		Given there is a contact "The Doctor"
		And I am on the show page for "The Doctor"
		When I click the "Add Phone Number" link
		And I select "Home" from "number_phone_type"
		And I fill in "number_number" with "14082182617"
		And I click the "Create Number" button
		Then I should see "Your number has been saved!"
		And I should be on the doctor's show page
		And I should see "14082182617"
	
	Scenario: A user should be able to edit an existing phone number
		Given There is a contact "Kirk" and they have a phone number "1231231234"
		And I am on the show page for "Kirk"
		And I should see "1231231234"
		When I click on the "Edit" link for "1231231234"
		And I select "Home" from "number_phone_type"
		And I fill in "number_number" with "9999999999"
		And I click the "Update Number" button
		Then I should see "Your phone number has been updated."
		And I should see "9999999999"
		And I should not see "1231231234"
		
	Scenario: A user should be able to delete an existing phone number	
		Given There is a contact "delete phone test" and they have a phone number "1111111111"
		And I am on the show page for "delete phone test"
		And I should see "1111111111"
		When I click on the "Delete" link for "1111111111"
		# And I confirm popup, not sure why this is working without confirming the pop up, however it is. 
		Then I should see "Your phone number has been deleted."
		And I am on the show page for "delete phone test"
		And I should not see "1111111111"