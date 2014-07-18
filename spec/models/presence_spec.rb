require 'spec_helper'

describe Presence, :type => :model do
  context "validation" do
    it "should create a valid web presence" do
      expect(FactoryGirl.build(:defaulted_presence)).to be_valid
    end
  end
  context "callbacks" do

    it "should not append an http if the url has an http" do
      expected_url = 'http://www.twitter.com'
      occasion = FactoryGirl.create(:defaulted_presence, { url: 'http://www.twitter.com' })
      expect(occasion.url).to eq(expected_url)
    end

    it "should append an http if it is missing on a url" do
      expected_url = 'http://www.twitter.com'
      occasion = FactoryGirl.create(:defaulted_presence, { url: 'www.twitter.com' })
      expect(occasion.url).to eq(expected_url)
    end

  end
end