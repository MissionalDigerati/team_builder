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
		And I should see "1(408) 218 2617"
	
	Scenario: A user should be able to edit an existing phone number
		Given There is a contact "Kirk" and they have a phone number "1231231234"
		And I am on the show page for "Kirk"
		And I should see "(123) 123 1234"
		When I click on the "Edit" link for "(123) 123 1234"
		And I select "Home" from "number_phone_type"
		And I fill in "number_number" with "9999999999"
		And I click the "Update Number" button
		Then I should see "Your phone number has been updated."
		And I should see "(999) 999 9999"
		And I should not see "(123) 123 1234"
		
	Scenario: A user should be able to delete an existing phone number	
		Given There is a contact "delete phone test" and they have a phone number "1111111111"
		And I am on the show page for "delete phone test"
		And I should see "(111) 111 1111"
		When I click on the "Delete" link for "(111) 111 1111"
		# And I confirm popup, not sure why this is working without confirming the pop up, however it is. 
		Then I should see "Your phone number has been deleted."
		And I am on the show page for "delete phone test"
		And I should not see "(111) 111 1111"
	
	Scenario: A user should be able to add a phone number for a contact through another contact
		Given given there are contacts "iphone" and "android"
		And I am on the show page for "iphone"
		When I click the "Add Phone Number" link
		And I select "android" from "Contact"
		And I select "Mobile" from "number_phone_type"
		And I fill in "number_number" with "2312321232"
		And I click the "Create Number" button
		Then I should see "Your number has been saved!"
		And I should be on the show page for "android"
		And I should see "(231) 232 1232"
		And I should see "Mobile"
		Then I am on the show page for "iphone"
		And I should not see "(231) 232 1232"	
		And I should not see "Mobile"		