require 'spec_helper'

describe SupportState do
  describe "validations" do
  	it "should create a valid record if all fields are present" do
  		contact = FactoryGirl.create(:defaulted_contact)
  		FactoryGirl.create(:defaulted_support_state, contact_id: contact.id).should be_valid
  	end
  end

  describe "methods" do
    it "should mark the state initial boolean as true and all others false" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:defaulted_support_state, contact_id: contact.id, initial: false)
      SupportState.initial_state(state)
      state.initial.should == true
    end

    it "should mark the state initial and letter_sent boolean as true and all others false" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:defaulted_support_state, contact_id: contact.id, initial: false, letter_sent: false, letter_sent_on: nil)
      SupportState.letter_sent(state)
      state.initial.should == true
      state.letter_sent.should == true
      state.letter_sent_on == Time.now.to_date
    end

    it "should mark the state initial, letter_sent, and contacting boolean as true and all others false" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:defaulted_support_state, contact_id: contact.id, initial: false, letter_sent: false, contacting: false)
      SupportState.contacting(state)
      state.initial.should == true
      state.letter_sent.should == true
      state.contacting.should == true
    end

    it "should delegate which method is called based on the params passed in" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:defaulted_support_state, contact_id: contact.id)

      SupportState.stub(:initial_state).and_return("initial_state")
      SupportState.state_edit_delegation(state.id, "initial").should == "initial_state"

      SupportState.stub(:letter_sent).and_return("letter_sent")
      SupportState.state_edit_delegation(state.id, "letter_sent").should == "letter_sent"

      SupportState.stub(:contacting).and_return("contacting")
      SupportState.state_edit_delegation(state.id, "contacting").should == "contacting"
    end

  end
end
