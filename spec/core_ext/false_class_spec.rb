describe FalseClass do
  context "Method yes_or_no" do
    it "should return yes" do
      false.yes_or_no.should == "No"
    end
  end
end