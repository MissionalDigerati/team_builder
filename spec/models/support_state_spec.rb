require 'spec_helper'


describe SupportState, :type => :model do
  describe "validations" do

  	it "should create a valid record if all fields are present" do
  		contact = FactoryGirl.create(:defaulted_contact)
  		expect(FactoryGirl.create(:starting_support_state, contact_id: contact.id)).to be_valid
  	end

    it "should not create a valid record if more than one state boolean is true" do
      contact = FactoryGirl.create(:defaulted_contact)
      expect(FactoryGirl.build(:starting_support_state, contact_id: contact.id, initial: true, seen_presentation: true)).not_to be_valid
    end

  end

  describe "after validations" do
     
    it "should calculate the support states progress percent based on the current state it's in" do
      contact_1 = FactoryGirl.create(:defaulted_contact)
      state_1 = FactoryGirl.create(:starting_support_state, contact_id: contact_1.id, initial: true, progress_percent: 0)
      expect(state_1.progress_percent).to eq(14)

      contact_2 = FactoryGirl.create(:defaulted_contact)
      state_2 = FactoryGirl.create(:starting_support_state, contact_id: contact_2.id, initial: false, letter_sent: true, progress_percent: 0)
      expect(state_2.progress_percent).to eq(32)

      contact_3 = FactoryGirl.create(:defaulted_contact)
      state_3 = FactoryGirl.create(:starting_support_state, contact_id: contact_3.id, initial: false, contacting: true, progress_percent: 0)
      expect(state_3.progress_percent).to eq(58)

      contact_4 = FactoryGirl.create(:defaulted_contact)
      state_4 = FactoryGirl.create(:starting_support_state, contact_id: contact_4.id, initial: false, seen_presentation: true, progress_percent: 0)
      expect(state_4.progress_percent).to eq(75)

      contact_5 = FactoryGirl.create(:defaulted_contact)
      state_5 = FactoryGirl.create(:starting_support_state, contact_id: contact_5.id, initial: false, following_up: true, progress_percent: 0)
      expect(state_5.progress_percent).to eq(85)

      contact_6 = FactoryGirl.create(:defaulted_contact)
      state_6 = FactoryGirl.create(:starting_support_state, contact_id: contact_6.id, initial: false, not_giving: true, progress_percent: 0)
      expect(state_6.progress_percent).to eq(100)

      contact_7 = FactoryGirl.create(:defaulted_contact)
      state_7 = FactoryGirl.create(:starting_support_state, contact_id: contact_7.id, initial: false, no_response: true, progress_percent: 0)
      expect(state_7.progress_percent).to eq(100)

      contact_8 = FactoryGirl.create(:defaulted_contact)
      state_8 = FactoryGirl.create(:starting_support_state, contact_id: contact_8.id, initial: false, monthly_gift: true, progress_percent: 0)
      expect(state_8.progress_percent).to eq(100)

      contact_9 = FactoryGirl.create(:defaulted_contact)
      state_9 = FactoryGirl.create(:starting_support_state, contact_id: contact_9.id, initial: false, one_time_gift: true, progress_percent: 0)
      expect(state_9.progress_percent).to eq(100)
    end

  end

	describe "scopes" do
		
		describe "count_by_progress" do
			it "should return the correct count" do
				contact = FactoryGirl.create(:defaulted_contact)
	      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, seen_presentation: true)
				contact2 = FactoryGirl.create(:defaulted_contact)
	      state2 = FactoryGirl.create(:starting_support_state, contact_id: contact2.id, initial: false, seen_presentation: true)
				expect(SupportState.count_by_progress(:seen_presentation)).to eq(2)
			end
			it "should return 0 if the progress_column does not exist" do
				expect(SupportState.count_by_progress(:not_a_progress)).to eq(nil)
			end
      it "should return results with multiple parameters" do
        contact = FactoryGirl.create(:defaulted_contact)
        state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: true, seen_presentation: false)
        contact2 = FactoryGirl.create(:defaulted_contact)
        state2 = FactoryGirl.create(:starting_support_state, contact_id: contact2.id, initial: false, seen_presentation: true)
        contact3 = FactoryGirl.create(:defaulted_contact)
        state3 = FactoryGirl.create(:starting_support_state, contact_id: contact3.id, initial: false, seen_presentation: true)
        expect(SupportState.count_by_progress(:initial, :seen_presentation)).to eq(3)
      end
		end
		
	end

  describe "methods" do
    it "should mark the state initial boolean as true and all others false" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, progress_percent: 14)
      SupportState.initial_state(state)
      expect(state.initial).to eq(true)
      expect(state.progress_percent).to eq(14)
    end

    it "should mark the letter_sent boolean as true and all others false, and mark the letter sent on date" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, letter_sent: false, letter_sent_on: nil)
      SupportState.letter_sent(state)
      expect(state.letter_sent).to eq(true)
      state.letter_sent_on == Time.now.to_date
    end

    it "should mark the state contacting state as true and all others false" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, letter_sent: false, contacting: false)
      SupportState.contacting(state)
      expect(state.initial).to eq(false)
      expect(state.letter_sent).to eq(false)
      expect(state.contacting).to eq(true)
    end

    it "should mark all states other than seen presentation false, and mark the seen presentation date with the current date" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, initial: false, seen_presentation: true, presented_on: Time.now.to_date)
      SupportState.seen_presentation(state)
      expect(state.seen_presentation).to eq(true)
      expect(state.presented_on).to eq(Time.now.to_date)
    end

    it "should mark all states other than follow up false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, following_up: false)
      SupportState.following_up(state)
      expect(state.following_up).to eq(true)
    end

		describe "current_progress" do
			
			it "should return the correct support state for a contact that is supporting Monthly" do
				contact = FactoryGirl.create(:defaulted_contact)
	      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, monthly_gift: true, initial: false)
				expect(contact.support_state.progress).to eq("Monthly Gift")
			end
			
			it "should return the correct support state for a contact that has shown no response" do
				contact = FactoryGirl.create(:defaulted_contact)
	      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, no_response: true, initial: false)
				expect(contact.support_state.progress).to eq("No Response")
			end
			
		end

    it "should mark all states other than one time gift false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, one_time_gift: false)
      SupportState.one_time_gift(state)
      expect(state.one_time_gift).to eq(true)
    end

    it "should mark all states other than monthly gift false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, monthly_gift: false)
      SupportState.monthly_gift(state)
      expect(state.monthly_gift).to eq(true)
    end

    it "should mark all states other than not giving false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, not_giving: false)
      SupportState.not_giving(state)
      expect(state.not_giving).to eq(true)
    end

    it "should mark all states other than no response false, and leave all date fields alone" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id, no_response: false)
      SupportState.no_response(state)
      expect(state.no_response).to eq(true)
    end

    it "should delegate which method is called based on the params passed in" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id)

      allow(SupportState).to receive(:initial_state).and_return("initial_state")
      expect(SupportState.state_edit_delegation(state.id, "initial_state")).to eq("initial_state")

      allow(SupportState).to receive(:letter_sent).and_return("letter_sent")
      expect(SupportState.state_edit_delegation(state.id, "letter_sent")).to eq("letter_sent")

      allow(SupportState).to receive(:contacting).and_return("contacting")
      expect(SupportState.state_edit_delegation(state.id, "contacting")).to eq("contacting")

      allow(SupportState).to receive(:seen_presentation).and_return("seen_presentation")
      expect(SupportState.state_edit_delegation(state.id, "seen_presentation")).to eq("seen_presentation")

      allow(SupportState).to receive(:following_up).and_return("following_up")
      expect(SupportState.state_edit_delegation(state.id, "following_up")).to eq("following_up")

      allow(SupportState).to receive(:one_time_gift).and_return("one_time_gift")
      expect(SupportState.state_edit_delegation(state.id, "one_time_gift")).to eq("one_time_gift")

      allow(SupportState).to receive(:monthly_gift).and_return("monthly_gift")
      expect(SupportState.state_edit_delegation(state.id, "monthly_gift")).to eq("monthly_gift")

      allow(SupportState).to receive(:not_giving).and_return("not_giving")
      expect(SupportState.state_edit_delegation(state.id, "not_giving")).to eq("not_giving")

      allow(SupportState).to receive(:no_response).and_return("no_response")
      expect(SupportState.state_edit_delegation(state.id, "no_response")).to eq("no_response")
    end

  end
end
