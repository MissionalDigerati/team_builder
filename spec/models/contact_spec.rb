require 'spec_helper'

describe Contact do
  context "validations" do
    it "should create a valid contact" do
      FactoryGirl.create(:defaulted_contact).should be_valid
    end
    
    it "should require first name" do
      FactoryGirl.build(:defaulted_contact, :first_name => nil).should_not be_valid
    end
    
    it "should require email" do
      FactoryGirl.build(:defaulted_contact, :email => nil).should_not be_valid
    end
  end
  
  context "methods" do
    
  end
  
end
  
