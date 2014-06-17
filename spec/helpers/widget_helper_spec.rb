require 'spec_helper'

describe WidgetHelper do

  context "methods" do

    context "#widget_donation_data" do

      it "should return the correctly structured data for the chart" do
        expected = [[0, 100], [1, 50], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0], [8, 0], [9, 0], [10, 0], [11, 0]]
        current_year = Time.now.strftime("%Y").to_s
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-01-#{current_year}"), :amount => 100.00})
        FactoryGirl.create(:defaulted_donation, {:donation_date => Time.parse("20-02-#{current_year}"), :amount => 50.00})
        widget_donation_data.should == expected
      end

    end

  end

end