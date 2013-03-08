require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DonationsHelper. For example:
#
# describe DonationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
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
