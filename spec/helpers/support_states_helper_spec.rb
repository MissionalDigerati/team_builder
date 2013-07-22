require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SupportStatesHelper. For example:
#
# describe SupportStatesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe SupportStatesHelper do
	describe "Methods" do

		it "should not return anything if there is not a state" do
	      	display_progress_bar(nil).should == nil
		end

		it "Should return the initial state progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: true, progress_percent: 14)
	      	display_progress_bar(state).should == "<div class='progress progress'><div class='bar bar-warning progress_text' style='width: 14%'>Initial</div></div>"
		end

		it "Should return the letter sent progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, letter_sent: true, progress_percent: 32)
	      	display_progress_bar(state).should == "<div class='progress progress'><div class='bar bar-warning progress_text' style='width: 32%'>Letter Sent</div></div>"
		end

		it "Should return the contacting state progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, contacting: true, progress_percent: 58)
	      	display_progress_bar(state).should == "<div class='progress'><div class='bar bar-info progress_text' style='width: 58%'>Contacting</div></div>"
		end

		it "Should return the seen presentation state progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, seen_presentation: true, progress_percent: 75)
	      	display_progress_bar(state).should == "<div class='progress'><div class='bar bar-info progress_text' style='width: 75%'>Seen Presentation</div></div>"
		end

		it "should return the following up state progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, following_up: true, progress_percent: 85)
	      	display_progress_bar(state).should == "<div class='progress'><div class='bar bar-info progress_text' style='width: 85%'>Following Up</div></div>"
		end

		it "should return the one time gift state progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, one_time_gift: true, progress_percent: 100)
	      	display_progress_bar(state).should == "<div class='progress'><div class='bar bar-success progress_text' style='width: 100%'>One Time Gift</div></div>"
		end

		it "should return the montly gift progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, monthly_gift: true, progress_percent: 100)
	      	display_progress_bar(state).should == "<div class='progress'><div class='bar bar-success progress_text' style='width: 100%'>Monthly Gift</div></div>"
		end

		it "should return the no response progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, no_response: true, progress_percent: 100)
	      	display_progress_bar(state).should == "<div class='progress'><div class='bar bar-danger progress_text' style='width: 100%'>No Response</div></div>"
		end

		it "should return the not giving progress bar" do
			contact = FactoryGirl.create(:defaulted_contact)
	      	state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, not_giving: true, progress_percent: 100)
	      	display_progress_bar(state).should == "<div class='progress'><div class='bar bar-danger progress_text' style='width: 100%'>Not Giving</div></div>"
		end
	end
end 
