require 'spec_helper'

describe Note, :type => :model do
 context "validations" do
  it "should create a valid note" do
    expect(FactoryGirl.build(:defaulted_note)).to be_valid
  end
  
  it "should require a contact_id" do
    expect(FactoryGirl.build(:defaulted_note, :contact_id => nil)).not_to be_valid
  end
  
  it "should require a note" do
    expect(FactoryGirl.build(:defaulted_note, :note => nil)).not_to be_valid
  end
 end
end