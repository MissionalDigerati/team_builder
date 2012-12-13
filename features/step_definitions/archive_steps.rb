require 'cucumber/rspec/doubles'
Then /^I should be on the archive page$/ do
  page.current_path.should == archives_path
end
Given /^there is a backup "(.*?)"$/ do |name|
  FactoryGirl.create(:archive, filename: name)
end
