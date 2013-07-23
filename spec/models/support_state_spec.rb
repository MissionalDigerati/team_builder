require 'spec_helper'

describe SupportState do
  describe "validations" do

  	it "should create a valid record if all fields are present" do
  		contact = FactoryGirl.create(:defaulted_contact)
  		FactoryGirl.create(:starting_support_state, contact_id: contact.id).should be_valid
  	end

    it "should not create a valid record if more than one state boolean is true" do
      contact = FactoryGirl.create(:defaulted_contact)
      FactoryGirl.build(:starting_support_state, contact_id: contact.id, initial: true, seen_presentation: true).should_not be_valid
    end

  end

	describe "scopes" do
		
		describe "count_by_progress" do
			it "should return the correct count" do
				contact = FactoryGirl.create(:defaulted_contact)
	      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, seen_presentation: true)
				contact2 = FactoryGirl.create(:defaulted_contact)
	      state2 = FactoryGirl.create(:starting_support_state, contact_id: contact2.id, initial: false, seen_presentation: true)
				SupportState.count_by_progress(:seen_presentation).should == 2
			end
			it "should return 0 if the progress_column does not exist" do
				SupportState.count_by_progress(:not_a_progress).should == nil
			end
		end
		
	end

  describe "methods" do
    it "should mark the state initial boolean as true and all others false" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, progress_percent: 14)
      SupportState.initial_state(state)
      state.initial.should == true
      state.progress_percent.should == 14
    end

    it "should mark the letter_sent boolean as true and all others false, and mark the letter sent on date" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, letter_sent: false, letter_sent_on: nil)
      SupportState.letter_sent(state)
      state.letter_sent.should == true
      state.letter_sent_on == Time.now.to_date
    end

    it "should mark the state contacting state as true and all others false" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, letter_sent: false, contacting: false)
      SupportState.contacting(state)
      state.initial.should == false
      state.letter_sent.should == false
      state.contacting.should == true
    end

    it "should mark all states other than seen presentation false, and mark the seen presentation date with the current date" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, seen_presentation: true, presented_on: Time.now.to_date)
      SupportState.seen_presentation(state)
      state.seen_presentation.should == true
      state.presented_on.should == Time.now.to_date
    end

    it "should mark all states other than follow up false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, following_up: false)
      SupportState.following_up(state)
      state.following_up.should == true
    end

		describe "current_progress" do
			
			it "should return the correct support state for a contact that is supporting Monthly" do
				contact = FactoryGirl.create(:defaulted_contact)
	      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, monthly_gift: true, initial: false)
				contact.support_state.progress.should == "Monthly Gift"
			end
			
			it "should return the correct support state for a contact that has shown no response" do
				contact = FactoryGirl.create(:defaulted_contact)
	      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, no_response: true, initial: false)
				contact.support_state.progress.should == "No Response"
			end
			
		end

    it "should mark all states other than one time gift false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, one_time_gift: false)
      SupportState.one_time_gift(state)
      state.one_time_gift.should == true
    end

    it "should mark all states other than monthly gift false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, monthly_gift: false)
      SupportState.monthly_gift(state)
      state.monthly_gift.should == true
    end

    it "should mark all states other than not giving false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, not_giving: false)
      SupportState.not_giving(state)
      state.not_giving.should == true
    end

    it "should mark all states other than no response false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, no_response: false)
      SupportState.no_response(state)
      state.no_response.should == true
    end

    it "should delegate which method is called based on the params passed in" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id)

      SupportState.stub(:initial_state).and_return("initial_state")
      SupportState.state_edit_delegation(state.id, "initial_state").should == "initial_state"

      SupportState.stub(:letter_sent).and_return("letter_sent")
      SupportState.state_edit_delegation(state.id, "letter_sent").should == "letter_sent"

      SupportState.stub(:contacting).and_return("contacting")
      SupportState.state_edit_delegation(state.id, "contacting").should == "contacting"

      SupportState.stub(:seen_presentation).and_return("seen_presentation")
      SupportState.state_edit_delegation(state.id, "seen_presentation").should == "seen_presentation"

      SupportState.stub(:following_up).and_return("following_up")
      SupportState.state_edit_delegation(state.id, "following_up").should == "following_up"

      SupportState.stub(:one_time_gift).and_return("one_time_gift")
      SupportState.state_edit_delegation(state.id, "one_time_gift").should == "one_time_gift"

      SupportState.stub(:monthly_gift).and_return("monthly_gift")
      SupportState.state_edit_delegation(state.id, "monthly_gift").should == "monthly_gift"

      SupportState.stub(:not_giving).and_return("not_giving")
      SupportState.state_edit_delegation(state.id, "not_giving").should == "not_giving"

      SupportState.stub(:no_response).and_return("no_response")
      SupportState.state_edit_delegation(state.id, "no_response").should == "no_response"
    end

  end
end
