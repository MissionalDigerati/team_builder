describe TrueClass do
  context "Method yes_or_no" do
    it "should return yes" do
      true.yes_or_no.should == "Yes"
    end
  end
end