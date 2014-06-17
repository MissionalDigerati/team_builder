require 'spec_helper'

describe DonationsHelper do
 	context "methods" do
 		it "should return the total amount of the contact has donated, it should default to 0.00" do
 			user = FactoryGirl.create(:defaulted_contact)
 			FactoryGirl.create(:defaulted_donation, contact_id: user.id, amount: 100.00)
 			user_donation_amount(user.donations).should == "Total donation amount: $100.00"

 			user_without_donations = FactoryGirl.create(:defaulted_contact) 			
 			user_donation_amount(user_without_donations.donations).should == "Total donation amount: $0.00"
 		end
 	end
end
