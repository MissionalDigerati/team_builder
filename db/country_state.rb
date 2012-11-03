require 'rubygems'
require 'active_record'
require 'mysql'

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql',
  :host => 'localhost',
  :user => 'root',
  :password => 'root',
  :database => 'cheesecake',
  :socket => '/Applications/MAMP/tmp/mysql/mysql.sock'
)

class Country < ActiveRecord::Base
end

class State < ActiveRecord::Base
end

File.open('States.yml', 'w') do |f|
  f.write "states:\n"
  State.all.each do |s|
    f.write " - id: #{s.id}\n"
    f.write "   state_long: #{s.state_long}\n"
    f.write "   state_short: #{s.state_short}\n"
  end

# for countries
# File.open('Countries.yml', 'w') do |f|
#   f.write "countries:\n"
#   Country.all.each do |c|
#     f.write " - id: #{c.id}\n"
#     f.write "   iso: #{c.iso}\n"
#     f.write "   name: #{c.name}\n"
#     f.write "   printable_name: #{c.printable_name}\n"
#     f.write "   iso3: #{c.iso3}\n"
#     f.write "   numcode: #{c.numcode}\n"
#   end
end

# countries = Country.all
# puts countries.to_yaml