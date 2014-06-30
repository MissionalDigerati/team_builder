describe NilClass do
  context "Method yes_or_no" do
    it "should return N/A" do
      expect(nil.yes_or_no).to eq("N/A")
    end
  end
end