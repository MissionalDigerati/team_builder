require 'spec_helper'

describe ApplicationHelper do
  context "methods" do
    
    it "should return a link to add fields through js on new contact form"
    
    it "should return a tag if indexing contact by tag" 
      
    
    it "should return completed if true" do
      status(true).should == "Completed"
    end
    
    it "should return In Progress if false" do
      status(false).should == "In Progress"
    end
    
    it "should return the first name of contact to which an attribute belongs to, capitalized" do
      fred = FactoryGirl.create(:defaulted_contact, :first_name => "fred")
      occasion = FactoryGirl.create(:defaulted_occasion, :contact_id => fred)
      first_name(occasion).should == "Fred"
    end
    
    it "should return the sum donated for all time" do
      FactoryGirl.create(:defaulted_donation, :amount => 100.00, :donation_date => 3.years.ago)
      FactoryGirl.create(:defaulted_donation, :amount => 200.00, :donation_date => 4.years.ago)
      FactoryGirl.create(:defaulted_donation, :amount => 300.00, :donation_date => 5.years.ago)
      donations_all_time.should == "$600.00"
    end
    
    it "should return the amount donated this year" do
      FactoryGirl.create(:defaulted_donation, :amount => 100.00, :donation_date => 1.month.ago.to_date)
      FactoryGirl.create(:defaulted_donation, :amount => 200.00, :donation_date => 5.weeks.ago.to_date)
      FactoryGirl.create(:defaulted_donation, :amount => 300.00, :donation_date => 5.years.ago.to_date)
      donation_this_year.should == "$300.00"
    end
    
    it "should return the html for an edit button with icon" do
      edit_button.should == "Edit <i class=\"icon-edit icon-white\"></i>"
    end
    
    it "should return the html for an delete button with icon" do
      delete_button.should == "Delete <i class=\"icon-trash icon-white\"></i>"
    end
    
    it "should return the html for an contact button with icon" do
      contact_button.should == "View Contact <i class=\"icon-user icon-white\"></i>"
    end
    
  end
end