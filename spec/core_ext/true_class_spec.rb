describe TrueClass do
  context "Method yes_or_no" do
    it "should return yes" do
      expect(true.yes_or_no).to eq("Yes")
    end
  end
end