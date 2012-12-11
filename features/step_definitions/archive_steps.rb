Then /^I should be on the archive page$/ do
  page.current_path.should == archives_path
end