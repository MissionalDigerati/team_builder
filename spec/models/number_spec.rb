require 'spec_helper'

describe Number, :type => :model do
  context "validation" do
    it "should create a valid phone number" do
      expect(FactoryGirl.create(:defaulted_number)).to be_valid
    end
  end
  
  context "before save method" do
    it "should strip phone number of all non numeric characters" do
      number = FactoryGirl.create(:defaulted_number, :number => "(323) 343-3434")
      expect(number.number).to eq("3233433434")
    end
  end
end
