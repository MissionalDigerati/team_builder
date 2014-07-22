require 'spec_helper'

describe Contact, :type => :model do
  context "validations" do
    it "should create a valid contact" do
      expect(FactoryGirl.create(:defaulted_contact)).to be_valid
    end
    
    it "should require first name" do
      expect(FactoryGirl.build(:defaulted_contact, :first_name => nil)).not_to be_valid
    end
    
    it "should require last name" do
      expect(FactoryGirl.build(:defaulted_contact, :last_name => nil)).not_to be_valid
    end
    
    it "should require email" do
      expect(FactoryGirl.build(:defaulted_contact, :email => nil)).not_to be_valid
    end
  end

  context "state machine with AASM" do

    it "should default the state to pending" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: nil)
      expect(contact.team_status).to eq('pending')
    end

    it "should allow a contact be set to sent_letter" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :sent_letter)
      expect(contact.team_status).to eq(:sent_letter)
    end

    it "should allow a contact be set to setting_up_a_meeting" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :setting_up_a_meeting)
      expect(contact.team_status).to eq(:setting_up_a_meeting)
    end

    it "should allow a contact be set to presented_vision" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :presented_vision)
      expect(contact.team_status).to eq(:presented_vision)
    end

    it "should allow a contact be set to following_up" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :following_up)
      expect(contact.team_status).to eq(:following_up)
    end

    it "should allow a contact be set to no_response" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :no_response)
      expect(contact.team_status).to eq(:no_response)
    end

    it "should allow a contact be set to cannot_give" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :cannot_give)
      expect(contact.team_status).to eq(:cannot_give)
    end

    it "should allow a contact be set to special_gift" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :special_gift)
      expect(contact.team_status).to eq(:special_gift)
    end

    it "should allow a contact be set to monthly_supporter" do
      contact = FactoryGirl.create(:defaulted_contact, team_status: :monthly_supporter)
      expect(contact.team_status).to eq(:monthly_supporter)
    end

  end
  
  context "methods" do

    context ".invite_to_team_percent" do

      it "should return the correct percent for pending" do
        expected_percent = 0
        contact = FactoryGirl.create(:defaulted_contact, team_status: :pending)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for sent_letter" do
        expected_percent = 20
        contact = FactoryGirl.create(:defaulted_contact, team_status: :sent_letter)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for setting_up_a_meeting" do
        expected_percent = 40
        contact = FactoryGirl.create(:defaulted_contact, team_status: :setting_up_a_meeting)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for presented_vision" do
        expected_percent = 60
        contact = FactoryGirl.create(:defaulted_contact, team_status: :presented_vision)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for following_up" do
        expected_percent = 80
        contact = FactoryGirl.create(:defaulted_contact, team_status: :following_up)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for no_response" do
        expected_percent = 100
        contact = FactoryGirl.create(:defaulted_contact, team_status: :no_response)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for cannot_give" do
        expected_percent = 100
        contact = FactoryGirl.create(:defaulted_contact, team_status: :cannot_give)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for special_gift" do
        expected_percent = 100
        contact = FactoryGirl.create(:defaulted_contact, team_status: :special_gift)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

      it "should return the correct percent for monthly_supporter" do
        expected_percent = 100
        contact = FactoryGirl.create(:defaulted_contact, team_status: :monthly_supporter)
        expect(contact.invite_to_team_percent).to eq(expected_percent)
      end

    end

    context ".update_team_status" do

      it "should return false if you pass a non AASM state" do
        default_contact = FactoryGirl.create(:defaulted_contact)
        expect(default_contact.update_team_status(:loves_yogurt)).to eq(false)
      end

      it "should return true and update if you pass a valid AASM state" do
        default_contact = FactoryGirl.create(:defaulted_contact)
        expect(default_contact.update_team_status(:monthly_supporter)).to eq(true)
        expect(default_contact.team_status).to eq(:monthly_supporter)
      end

      it "should update presented_vision when the state is set to :presented_vision" do
        default_contact = FactoryGirl.create(:defaulted_contact, presented_vision: false)
        expect(default_contact.update_team_status(:presented_vision)).to eq(true)
        expect(default_contact.presented_vision).to eq(true)
      end

      it "should update sent_letter when the state is set to :sent_letter" do
        default_contact = FactoryGirl.create(:defaulted_contact, sent_letter: false)
        expect(default_contact.update_team_status(:sent_letter)).to eq(true)
        expect(default_contact.sent_letter).to eq(true)
      end

      it "should updated the team_status_updated_on field when updated" do
        default_contact = FactoryGirl.create(:defaulted_contact, team_status_updated_on: Date.parse('2001-12-01'))
        expect(default_contact.update_team_status(:sent_letter)).to eq(true)
        expect(default_contact.team_status_updated_on).to eq(Date.today)
      end

    end

    context ".family_name" do

      it "should only return the fullname if no spouse" do
        contact = FactoryGirl.create(:defaulted_contact, :first_name => "Woody", :last_name => "Harrison", :spouse_name => "")
        expect(contact.family_name).to eq("Woody Harrison")
      end

      it "should return the husband & wife full name if spouse" do
        contact = FactoryGirl.create(:defaulted_contact, :first_name => "Bobby", :last_name => "Smith", :spouse_name => "Sue")
        expect(contact.family_name).to eq("Bobby & Sue Smith")
      end

    end

    it "should return number of non believers" do
      FactoryGirl.create(:defaulted_contact, :believer => false)
      FactoryGirl.create(:defaulted_contact, :believer => false)
      FactoryGirl.create(:defaulted_contact, :believer => true)
      expect(Contact.non_believers).to eq(2)
    end
    
    it "should return the total number of contacts" do
      FactoryGirl.create(:defaulted_contact)
      FactoryGirl.create(:defaulted_contact)
      FactoryGirl.create(:defaulted_contact)
      FactoryGirl.create(:defaulted_contact)
      expect(Contact.contact_count).to eq(4)
    end
    
    
    it "should return the number of contacts that have donated" do
      FactoryGirl.create(:defaulted_contact, :donations_count => 3)
      FactoryGirl.create(:defaulted_contact, :donations_count => 1)
      expect(Contact.donated_contacts).to eq(2)
    end
    
    it "should return the number of contacts created within the last month" do
      FactoryGirl.create(:defaulted_contact, :created_at => 4.weeks.ago.to_date)
      FactoryGirl.create(:defaulted_contact, :created_at => 2.weeks.ago.to_date)
      expect(Contact.contacts_in_last_month).to eq(2)
    end
    
    it "should return the number of contacts created within the last year" do
      FactoryGirl.create(:defaulted_contact, :created_at => 1.year.ago.to_date)
      expect(Contact.contacts_in_last_year).to eq(1)
    end
    

    it 'should return the full name of the corresponding contact' do
      wilson = FactoryGirl.create(:defaulted_contact, :first_name => "Mister", :last_name => "Wilson")
      expect(wilson.fullname).to eq("Mister Wilson")
    end

    it "should return searches by programming language tag or by search depending on what arguments are provided" do
      user_without_tag = FactoryGirl.create(:defaulted_contact, first_name: "Fred")
      search = Contact.contact_index("Fred")
      expect(search.length).to eq(1)
      expect(search.first).to eq(user_without_tag) 
    end

    it "should only search by tags" do |variable|
      user_with_tag = FactoryGirl.create(:defaulted_contact, tag_list: "fred")
      user_without_tag = FactoryGirl.create(:defaulted_contact, first_name: "fred")
      search = Contact.tag_search("fred")
      expect(search.length).to eq(1)
      expect(search.first).to eq(user_with_tag)
    end

  end
end