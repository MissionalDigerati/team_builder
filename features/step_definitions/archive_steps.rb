Then /^I should be on the archive page$/ do
  expect(page.current_path).to eq(archives_path)
end
Given /^there is a backup "(.*?)"$/ do |name|
  FactoryGirl.create(:archive, filename: name)
end
