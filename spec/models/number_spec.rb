require 'spec_helper'

describe Number do
  context "validation" do
    it "should create a valid phone number" do
      FactoryGirl.create(:defaulted_number).should be_valid
    end
  end
end
