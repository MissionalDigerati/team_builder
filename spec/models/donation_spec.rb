require 'spec_helper'

describe Donation, :type => :model do
  context "validations" do
    it "should create a valid task" do
      expect(FactoryGirl.build(:defaulted_donation)).to be_valid
    end
    
    it "should require an ammount" do
      expect(FactoryGirl.build(:defaulted_donation, :amount => nil)).not_to be_valid
    end
    
    it "should require an project" do
      expect(FactoryGirl.build(:defaulted_donation, :project => nil)).not_to be_valid
    end
    
    it "should require an contact_id" do
      expect(FactoryGirl.build(:defaulted_donation, :contact_id => nil)).not_to be_valid
    end
    
    it "should only allow amounts over 0" do
      expect(FactoryGirl.build(:defaulted_donation, :amount => 0)).not_to be_valid
    end
  end
  
  context "methods" do
    it "should return the sum donated this month" do
      FactoryGirl.create(:defaulted_donation)
      FactoryGirl.create(:defaulted_donation)
      expect(Donation.this_month_sum).to eq(144.5)
    end
    
    it "should return the average donation this year" do
      FactoryGirl.create(:defaulted_donation)
      FactoryGirl.create(:defaulted_donation)
      FactoryGirl.create(:defaulted_donation)
      expect(Donation.average_donation).to eq(72.25)
    end

    context "#monthly_sums" do

      it "should return an array of zeros for each month by default" do
        expected = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        expect(Donation.monthly_sums('2013')).to eq(expected)
      end

      it "should return an array of sums for each month" do
        expected = [100, 100, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2013"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2013"), :amount => 50.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-01-2013"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-02-2013"), :amount => 100.00})
        expect(Donation.monthly_sums('2013')).to eq(expected)
      end

      it "should return only data for the given year" do
        expected = [0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2012"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2012"), :amount => 50.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-01-2012"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-02-2013"), :amount => 100.00})
        expect(Donation.monthly_sums('2013')).to eq(expected)
      end

      it "should return values rounded up" do
        expected = [35, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-01-2011"), :amount => 34.55})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-02-2011"), :amount => 49.95})
        expect(Donation.monthly_sums('2011')).to eq(expected)
      end

    end

    context "#yearly_sums" do

        it "should return an hash of years and sums for donations" do
            expected = {'2005' => 500, '2006' => 400}
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2005"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2005"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2006"), :amount => 400.00})
            expect(Donation.yearly_sums).to eq(expected)
        end

        it "should return an empty hash if there are no sums" do
            expect(Donation.yearly_sums).to eq({})
        end

        it "should only return the last 10 years" do
            expected = {'2005' => 500, '2006' => 500}
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2002"), :amount => 1000.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2003"), :amount => 550.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2004"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-03-2005"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-04-2005"), :amount => 250.00})
            FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-04-2006"), :amount => 500.00})
            expect(Donation.yearly_sums).to eq(expected)
        end

    end
  end
  
  context "before_validation methods" do
    it "should remove symbols from amount currency" do
      skip "we need to figure out how to test this"
      donaiton = FactoryGirl.create(:defaulted_donation, :amount => "$400.00")
      expect(donation.amount).not_to eq("$400.00")
      expect(donation.amount).to eq(400.00)
    end
    
  end
end
