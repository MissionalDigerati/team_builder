require 'spec_helper'

describe Note do
 context "validations" do
  it "should create a valid note" do
    FactoryGirl.build(:defaulted_note).should be_valid
  end
  
  it "should require a contact_id" do
    FactoryGirl.build(:defaulted_note, :contact_id => nil).should_not be_valid
  end
  
  it "should require a note" do
    FactoryGirl.build(:defaulted_note, :note => nil).should_not be_valid
  end
 end
end