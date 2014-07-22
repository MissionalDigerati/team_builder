require 'spec_helper'

describe WidgetHelper, :type => :helper do

  context "methods" do

    context "#widget_donation_data" do

      it "should return the correctly structured data for the chart" do
        expected = [[0, 100], [1, 50], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0], [8, 0], [9, 0], [10, 0], [11, 0]]
        current_year = Time.now.strftime("%Y").to_s
        FactoryGirl.create(:defaulted_donation, {donation_date: Time.parse("20-01-#{current_year}"), amount: 100.00})
        FactoryGirl.create(:defaulted_donation, {donation_date: Time.parse("20-02-#{current_year}"), amount: 50.00})
        expect(widget_donation_this_year_data).to eq(expected)
      end

    end

    context "#widget_team_status_summary_data" do

      it "should return the correctly structured data for the chart" do
        expected = [
          {label: "Pending (3)", data: 3, color: '#8dd8ee'},
          {label: "Sent Letter (2)", data: 2, color: '#a8e651'},
          {label: "Setting Up A Meeting (1)", data: 1, color: '#5584ed'},
          {label: "Presented Vision (1)", data: 1, color: '#f7f156'},
          {label: "Following Up (2)", data: 2, color: '#5584ed'},
          {label: "No Response (1)", data: 1, color: '#ad1564'},
          {label: "Cannot Give (2)", data: 2, color: '#ad1564'},
          {label: "Special Gift (1)", data: 1, color: '#60ad15'},
          {label: "Monthly Supporter (3)", data: 3, color: '#60ad15'}
        ].to_json
        FactoryGirl.create(:defaulted_contact, team_status: :pending)
        FactoryGirl.create(:defaulted_contact, team_status: :pending)
        FactoryGirl.create(:defaulted_contact, team_status: :pending)
        FactoryGirl.create(:defaulted_contact, team_status: :sent_letter)
        FactoryGirl.create(:defaulted_contact, team_status: :sent_letter)
        FactoryGirl.create(:defaulted_contact, team_status: :setting_up_a_meeting)
        FactoryGirl.create(:defaulted_contact, team_status: :presented_vision)
        FactoryGirl.create(:defaulted_contact, team_status: :following_up)
        FactoryGirl.create(:defaulted_contact, team_status: :following_up)
        FactoryGirl.create(:defaulted_contact, team_status: :no_response)
        FactoryGirl.create(:defaulted_contact, team_status: :cannot_give)
        FactoryGirl.create(:defaulted_contact, team_status: :cannot_give)
        FactoryGirl.create(:defaulted_contact, team_status: :special_gift)
        FactoryGirl.create(:defaulted_contact, team_status: :monthly_supporter)
        FactoryGirl.create(:defaulted_contact, team_status: :monthly_supporter)
        FactoryGirl.create(:defaulted_contact, team_status: :monthly_supporter)
        expect(widget_team_status_summary_data).to eq(expected)
      end


    end

  end

end
