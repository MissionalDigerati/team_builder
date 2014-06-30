require 'spec_helper'

describe DonationsHelper, :type => :helper do
 	context "methods" do
 		it "should return the total amount of the contact has donated, it should default to 0.00" do
 			user = FactoryGirl.create(:defaulted_contact)
 			FactoryGirl.create(:defaulted_donation, contact_id: user.id, amount: 100.00)
 			expect(user_donation_amount(user.donations)).to eq("Total donation amount: $100.00")

 			user_without_donations = FactoryGirl.create(:defaulted_contact) 			
 			expect(user_donation_amount(user_without_donations.donations)).to eq("Total donation amount: $0.00")
 		end
 	end
end
