require 'spec_helper'

describe Presence do
  context "validation" do
    it "should create a valid web presence" do
      FactoryGirl.build(:defaulted_presence).should be_valid
    end
  end
end