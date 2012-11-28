require 'spec_helper'

describe Donation do
  context "validations" do
    it "should create a valid task" do
      FactoryGirl.build(:defaulted_donation).should be_valid
    end
    
    it "should require an ammount" do
      FactoryGirl.build(:defaulted_donation, :amount => nil).should_not be_valid
    end
    
    it "should require an project" do
      FactoryGirl.build(:defaulted_donation, :project => nil).should_not be_valid
    end
    
    it "should require an contact_id" do
      FactoryGirl.build(:defaulted_donation, :contact_id => nil).should_not be_valid
    end
    
    it "should only allow amounts over 0" do
      FactoryGirl.build(:defaulted_donation, :amount => 0).should_not be_valid
    end
  end
  
  context "methods" do
    it "should return the sum donated this month" do
      FactoryGirl.create(:defaulted_donation)
      FactoryGirl.create(:defaulted_donation)
      Donation.this_month_sum.should == 144.5
    end
    
    it "should return the average donation this year" do
      FactoryGirl.create(:defaulted_donation)
      FactoryGirl.create(:defaulted_donation)
      FactoryGirl.create(:defaulted_donation)
      Donation.average_donation.should == 72.25
    end
  end
  
  context "before_validation methods" do
    it "should remove symbols from amount currency" do
      pending "we need to figure out how to test this"
      donaiton = FactoryGirl.create(:defaulted_donation, :amount => "$400.00")
      donation.amount.should_not == "$400.00"
      donation.amount.should == 400.00
    end
    
  end
end
