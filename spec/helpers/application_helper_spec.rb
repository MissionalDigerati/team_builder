require 'spec_helper'

describe ApplicationHelper, :type => :helper do
  context "methods" do
    
    it "should return completed if true" do
      expect(status(true)).to eq("Completed")
    end
    
    it "should return In Progress if false" do
      expect(status(false)).to eq("In Progress")
    end
    
    it "should return an array, containting and array of contacts names and id's for forms. Last name, first name, then id, in alphabetical order by last name then first name" do
      FactoryGirl.create(:defaulted_contact)
      FactoryGirl.create(:defaulted_contact, :first_name => "Fred")
      FactoryGirl.create(:defaulted_contact, :first_name => "Abacabb", :last_name => "Zeffer")
      expect(form_select).to eq([["Williams, Fred", 2], ["Williams, Rory", 1], ["Zeffer, Abacabb", 3]])
    end
    
    it "should return the first name of contact to which an attribute belongs to, capitalized" do
      fred = FactoryGirl.create(:defaulted_contact, :first_name => "fred")
      occasion = FactoryGirl.create(:defaulted_occasion, :contact_id => fred.id)
      expect(first_name(occasion)).to eq("Fred")
    end
    
    it "should return the sum donated for all time" do
      FactoryGirl.create(:defaulted_donation, :amount => 100.00, :donation_date => 3.years.ago)
      FactoryGirl.create(:defaulted_donation, :amount => 200.00, :donation_date => 4.years.ago)
      FactoryGirl.create(:defaulted_donation, :amount => 300.00, :donation_date => 5.years.ago)
      expect(donations_all_time).to eq("$600.00")
    end
    
    it "should return the amount donated this year" do
      FactoryGirl.create(:defaulted_donation, :amount => 100.00, :donation_date => 1.month.ago.to_date)
      FactoryGirl.create(:defaulted_donation, :amount => 200.00, :donation_date => 5.weeks.ago.to_date)
      FactoryGirl.create(:defaulted_donation, :amount => 300.00, :donation_date => 5.years.ago.to_date)
      expect(donation_this_year).to eq("$300.00")
    end
    
    it "should return the html for an edit button with icon" do
      expect(edit_button).to eq("Edit <i class=\"fa fa-edit\"></i>")
    end
    
    it "should return the html for an delete button with icon" do
      expect(delete_button).to eq("Delete <i class=\"fa fa-trash-o\"></i>")
    end
    
    it "should return the html for an contact button with icon" do
      expect(contact_button).to eq("View Contact <i class=\"fa fa-user\"></i>")
    end
    
    it "should return the last name of the instance followed by a comma, followed by the first letter of the first name, all names are titalized." do
      ron = FactoryGirl.create(:defaulted_contact, :first_name => "ron", :last_name => "Weasley")
      donation = FactoryGirl.create(:defaulted_donation, :contact_id => ron.id)
      expect(summary_name_helper(donation)).to eq("Weasley, R")
    end

    it "should return a button with method post for the quick editing of a support state when the method name is suppied" do
      contact = FactoryGirl.create(:defaulted_contact)
      expect(state_quick_edit(contact, contact.support_state, "initial", true)).to eq("<a class=\"btn true\" data-method=\"put\" data-remote=\"true\" href=\"/contacts/1/support_states/1/quick_edit?current_state=initial\" rel=\"nofollow\">Initial</a>")
    end

    it "should return the number of contacts, if nil then it will return 0" do
      expect(number_of_contacts).to eq(0)
      contact = FactoryGirl.create(:defaulted_contact)
      expect(number_of_contacts).to eq(1)
    end

    it "should return the number of overdue tasks" do
      expect(number_of_overdue_tasks).to eq(0)
      FactoryGirl.create(:defaulted_task, completed: false, due_date: 1.weeks.ago.to_date)
      expect(number_of_overdue_tasks).to eq(1)
    end

    it "return the number of special dates occuring today" do
      expect(occasions_today).to eq(0)
      FactoryGirl.create(:defaulted_occasion, special_date: Time.now.to_date)
      expect(occasions_today).to eq(1)
    end
    
  end
end