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

    it "should delegate which method is called based on the params passed in" do
      contact = FactoryGirl.create(:defaulted_contact)
      state = FactoryGirl.create(:defaulted_support_state, contact_id: contact.id)

      SupportState.stub(:initial_state).and_return("initial_state")
      SupportState.state_edit_delegation(state.id, "initial").should == "initial_state"

    end

  end
end
