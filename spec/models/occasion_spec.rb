require 'spec_helper'

describe Occasion do
    context "validation" do
        it "should created a valid user" do
            FactoryGirl.create(:defaulted_occasion).should be_valid
        end
    end

    context "methods" do
        context "#calendar_date" do

            it "should return a date with the current year if it is reoccuring" do
                expected_year = Date.today.year
                occasion = FactoryGirl.create(:defaulted_occasion, { special_date: Date.parse('2001-12-01') })
                occasion.calendar_date.year.should == expected_year
            end
        end
    end
end