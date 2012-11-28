require 'spec_helper'

describe Occasion do
  context "validation" do
    it "should created a valid user" do
      FactoryGirl.create(:defaulted_occasion).should be_valid
    end
  end
end