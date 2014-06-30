describe FalseClass do
  context "Method yes_or_no" do
    it "should return yes" do
      expect(false.yes_or_no).to eq("No")
    end
  end
end