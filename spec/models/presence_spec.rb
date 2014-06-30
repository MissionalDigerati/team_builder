require 'spec_helper'

describe Presence, :type => :model do
  context "validation" do
    it "should create a valid web presence" do
      expect(FactoryGirl.build(:defaulted_presence)).to be_valid
    end
  end
end