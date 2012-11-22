
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# SCRIPT FOR CREATING DATA FOR STATES AND COUNTRIES
State.destroy_all
Country.destroy_all

countries = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "Countries.yml"))
states = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "States.yml"))

countries['countries'].each do |c|
  puts c
  Country.create({iso: c['iso'], name: c['name'], printable_name: c['printable_name'], iso3: c['iso3'], numcode: c['numcode']})
end

states['states'].each do |s|
  State.create({state_long: s['state_long'], state_short: s['state_short']})
end
