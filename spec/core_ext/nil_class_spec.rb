describe NilClass do
  context "Method yes_or_no" do
    it "should return N/A" do
      nil.yes_or_no.should == "N/A"
    end
  end
end