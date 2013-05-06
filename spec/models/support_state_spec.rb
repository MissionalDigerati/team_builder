require 'spec_helper'

describe SupportState do
  describe "validations" do
  	it "should create a valid record if all fields are present" do
  		contact = FactoryGirl.create(:defaulted_contact)
  		FactoryGirl.create(:defaulted_support_state, contact_id: contact.id).should be_valid
  	end

  	it "should not create a valid record if all of the fields are not present" do
  		FactoryGirl.build(:defaulted_support_state, seen_presentation: nil).should_not be_valid
  	end
  end
end
