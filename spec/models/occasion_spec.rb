require 'spec_helper'

describe Occasion, :type => :model do
  context "validation" do
    it "should created a valid user" do
      expect(FactoryGirl.create(:defaulted_occasion)).to be_valid
    end
  end

  context "methods" do

    context "#calendar_date" do

      it "should return a date with the current year if it is reoccuring" do
        expected_year = Date.today.year
        occasion = FactoryGirl.create(:defaulted_occasion, { special_date: Date.parse('2001-12-01') })
        expect(occasion.calendar_date.year).to eq(expected_year)
      end

    end
  end
end