Before do
  State.create(state_long: "California", state_short: "CA")
  State.create(state_long: "New York", state_short: "NY")
  Country.create(name: "United States", printable_name: "United States")
  Country.create(name: "CHINA", printable_name: "China")
end

After('@archive') do
  FileUtils.rm Dir.glob(Rails.root.join('backups', '*.tgz'))
end