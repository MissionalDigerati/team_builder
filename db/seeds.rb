
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# SCRIPT FOR CREATING DATA FOR STATES AND COUNTRIES
# State.destroy_all
# Country.destroy_all
# 
# countries = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "Countries.yml"))
# states = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "States.yml"))
# 
# countries['countries'].each do |c|
#   puts c
#   Country.create({iso: c['iso'], name: c['name'], printable_name: c['printable_name'], iso3: c['iso3'], numcode: c['numcode']})
# end
# 
# states['states'].each do |s|
#   State.create({state_long: s['state_long'], state_short: s['state_short']})
# end

# 99.times do |n|
#   competitor1 = "competitor_1_#{n+1}"
#   competitor2 = "competitor_2_#{n+1}"
#   details = "details#{n+1}"
#   Competition.create!(competitor1: competitor1,
#                competitor2: competitor2,
#                details: details,
#                user_id: 3,
#                publish: true)
# end

# script for creating contacts
# 99.times do |x|
#   first_name = "first_name #{x+1}"
#   last_name = "last_name #{x+1}"
#   email = "contact#{x+1}@testemail.com"
#   Contact.create!(first_name: first_name, last_name: last_name, spouse_name: "filler", email: email, state_id: 5, country_id: 465, receive_newsletter: true, believer: true)
# end
# 
# Donation.delete_all

5.times do |x|
  # Occasion.create!(contact_id: 3, occasion: "birthday", special_date: "2007-11-12")
  # Number.create!(contact_id: 3, phone_type: "mobile", number: "#{x+1}")
  # Donation.create!(contact_id: 3, date: "1/12/2013", amount: "#{x+20}", project: "team builder")
  Task.create!(contact_id: 3, completed: false, task: "task #{x+1}", due_date: "21/11/2012", category: "Call")
end

#<Task id: nil, contact_id: nil, completed: false, task: nil, due_date: nil, category: nil, created_at: nil, updated_at: nil> 

#<Occasion id: nil, day: nil, month: nil, year: nil, occasion: nil, created_at: nil, updated_at: nil, contact_id: nil>

#<Contact id: nil, first_name: nil, last_name: nil, spouse_name: nil, email: nil, spouse_email: nil, tags: nil, network: nil, 
# address_1: nil, address_2: nil, city: nil, state_id: nil, zip: nil, country_id: nil, receive_newsletter: false, children: nil, 
# preferred_contact: nil, created_at: nil, updated_at: nil, believer: nil> 
# 1.9.3p125 :002 >