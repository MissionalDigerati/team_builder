namespace :db do
	
	desc "Adds the Fat Free data in db/seeds/fat_free.yml"
  task :ff_populate => :environment do
		contacts = YAML.load_file(File.join(Rails.root.to_s, "db", "seeds", "fat_free.yml"))['contacts']
		contacts.each do |c|
			puts "Adding #{c['first_name']} #{c['last_name']}."
			nc = Contact.new
			nc.first_name = c['first_name']
			nc.last_name = c['last_name']
			nc.spouse_name = c['spouse_name']
			nc.email = c['email']
			nc.spouse_email = c['spouse_email']
			nc.network = c['network']
			nc.address_1 = c['address_1']
			nc.address_2 = c['address_2']
			nc.city = c['city']
			nc.state_id = c['state_id']
			nc.zip = c['zip']
			nc.country_id = c['country_id']
			nc.receive_newsletter = c['receive_newsletter']
			nc.children = c['children']
			nc.preferred_contact = c['preferred_contact']
			nc.believer = c['believer']
			nc.tag_list = c['tags']
			nc.save(validate: false)
			unless c['numbers'] == ''
				c['numbers'].each do |n|
					nc.numbers.new({phone_type: n['phone_type'], number: n['number']}).save
				end
			end
			unless c['occasions'] == ''
				c['occasions'].each do |o|
					nc.occasions.new({occasion: o['occasion'], special_date: o['special_date']}).save
				end
			end
			unless c['presences'] == ''
				c['presences'].each do |p|
					nc.presences.new({site: p['site'], url: p['url'], account: p['account']}).save
				end
			end
		end
	end
	
	desc "Adds the Fat Free data for spouses"
  task :ff_spouse_populate => :environment do
		ff_database = YAML.load_file(File.join(Rails.root.to_s, "config", "db_fat_free.yml"))['fatfree']
		puts ff_database
	end
	
end