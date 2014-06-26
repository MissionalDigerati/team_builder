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

    context "#monthly_sums" do

      it "should return an array of zeros for each month by default" do
        expected = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        Donation.monthly_sums('2013').should == expected
      end

      it "should return an array of sums for each month" do
        expected = [100, 100, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2013"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2013"), :amount => 50.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-01-2013"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-02-2013"), :amount => 100.00})
        Donation.monthly_sums('2013').should == expected
      end

      it "should return only data for the given year" do
        expected = [0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2012"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2012"), :amount => 50.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-01-2012"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-02-2013"), :amount => 100.00})
        Donation.monthly_sums('2013').should == expected
      end

      it "should return values rounded up" do
        expected = [35, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-01-2011"), :amount => 34.55})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-02-2011"), :amount => 49.95})
        Donation.monthly_sums('2011').should == expected
      end

    end

    context "#yearly_sums" do

        it "should return an hash of years and sums for donations" do
            expected = {'2004' => 250, '2005' => 500, '2006' => 400}
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2004"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2005"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2005"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2006"), :amount => 400.00})
            Donation.yearly_sums.should == expected
        end

        it "should return an empty hash if there are no sums" do
            Donation.yearly_sums.should == {}
        end

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
