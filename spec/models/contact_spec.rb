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
  end
  
  context "methods" do

    context ".family_name" do

      it "should only return the fullname if no spouse" do
        contact = FactoryGirl.create(:defaulted_contact, :first_name => "Woody", :last_name => "Harrison", :spouse_name => "")
        contact.family_name.should eq("Woody Harrison")
      end

      it "should return the husband & wife full name if spouse" do
        contact = FactoryGirl.create(:defaulted_contact, :first_name => "Bobby", :last_name => "Smith", :spouse_name => "Sue")
        contact.family_name.should eq("Bobby & Sue Smith")
      end

    end

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

    it "should return searches by programming language tag or by search depending on what arguments are provided" do
      user_with_tag = FactoryGirl.create(:defaulted_contact, tag_list: "doctor")
      user_without_tag = FactoryGirl.create(:defaulted_contact, first_name: "Fred")

      tag_query = Contact.contact_index("doctor", nil)
      tag_query.length.should == 1
      tag_query.first.should == user_with_tag

      search = Contact.contact_index(nil, "Fred")
      search.length.should == 1
      search.first.should == user_without_tag 
    end

    it "should only search by tags" do |variable|
      user_with_tag = FactoryGirl.create(:defaulted_contact, tag_list: "fred")
      user_without_tag = FactoryGirl.create(:defaulted_contact, first_name: "fred")
      search = Contact.tag_search("fred")
      search.length.should == 1
      search.first.should == user_with_tag
    end

    it "should query all contacts including their support state." do
      contact = FactoryGirl.create(:defaulted_contact, tag_list: "fred")
      state = FactoryGirl.create(:starting_support_state, contact_id: contact.id)
      query = Contact.contact_report_query
      query.first.should == contact
      query.first.support_state.should == state
    end

  end
end