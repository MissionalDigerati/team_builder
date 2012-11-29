require 'spec_helper'

describe Number do
  context "validation" do
    it "should create a valid phone number" do
      FactoryGirl.create(:defaulted_number).should be_valid
    end
  end
  
  context "before save method" do
    it "should strip phone number of all non numeric characters" do
      number = FactoryGirl.create(:defaulted_number, :number => "(323) 343-3434")
      number.number.should == "3233433434"
    end
  end
end
