require 'spec_helper'

describe Contact do
  context "validations" do
    it "should create a valid contact" do
      FactoryGirl.create(:defaulted_contact).should be_valid
    end
    
    it "should require first name" do
      FactoryGirl.build(:defaulted_contact, :first_name => nil).should_not be_valid
    end
    
    it "should require last name" do
      FactoryGirl.build(:defaulted_contact, :last_name => nil).should_not be_valid
    end
    
    it "should require email" do
      FactoryGirl.build(:defaulted_contact, :email => nil).should_not be_valid
    end
    
    it "should capitalize the first and last name of the contacts via before filter" do
      amy = FactoryGirl.create(:defaulted_contact, :first_name => "amy", :last_name => "pond")
      amy.first_name.should == "Amy"
      amy.last_name.should == "Pond"
    end
    
    it "should capitalize keep the names capitalized if they are entered capitalized" do
      amy = FactoryGirl.create(:defaulted_contact, :first_name => "Amy", :last_name => "Pond")
      amy.first_name.should == "Amy"
      amy.last_name.should == "Pond"
    end
    
    it "it should only capitalize the first letter of the string for first and last name" do
      amy = FactoryGirl.create(:defaulted_contact, :first_name => "the Doctor", :last_name => "mcCormic")
      amy.first_name.should == "The Doctor"
      amy.last_name.should == "McCormic"
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
    

    it 'should return the full name of the corresponding contact' do
      wilson = FactoryGirl.create(:defaulted_contact, :first_name => "Mister", :last_name => "Wilson")
      wilson.fullname.should == "Mister Wilson"
    end

    it "should return the full name of the contact" do
      rory = FactoryGirl.create(:defaulted_contact)
      rory.full_name.should == "Rory Williams"
    end
    
  end
end