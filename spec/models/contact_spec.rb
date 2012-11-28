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
    it "should return number of non believers" do
      FactoryGirl.create(:defaulted_contact, :believer => false)
      FactoryGirl.create(:defaulted_contact, :believer => false)
      FactoryGirl.create(:defaulted_contact, :believer => true)
      Contact.non_believers.should == 2
    end
    
    it "should return the total number of contacts" do
      FactoryGirl.create(:defaulted_contact)
      FactoryGirl.create(:defaulted_contact)
      FactoryGirl.create(:defaulted_contact)
      FactoryGirl.create(:defaulted_contact)
      Contact.contact_count.should == 4
    end
    
    
    it "should return the number of contacts that have donated" do
      FactoryGirl.create(:defaulted_contact, :donations_count => 3)
      FactoryGirl.create(:defaulted_contact, :donations_count => 1)
      Contact.donated_contacts.should == 2
    end
    
    it "should return the number of contacts created within the last month" do
      FactoryGirl.create(:defaulted_contact, :created_at => 4.weeks.ago.to_date)
      FactoryGirl.create(:defaulted_contact, :created_at => 2.weeks.ago.to_date)
      Contact.contacts_in_last_month.should == 2
    end
    
    it "should return the number of contacts created within the last year" do
      FactoryGirl.create(:defaulted_contact, :created_at => 1.year.ago.to_date)
      Contact.contacts_in_last_year.should == 1
    end
  end
end