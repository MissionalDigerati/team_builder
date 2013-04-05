namespace :cten do
	
	desc "Generate the contact Excel file of Contacts to add to Denari Online"
  	task :generate_contact_excel => :environment do
  		book = Spreadsheet::Workbook.new
  		worksheet = book.create_worksheet :name => "Sheet 1"
  		worksheet.row(0).concat %w{Org_name First Last_name Spouse ContactName Salutation Street Street2 City State Zip Country Email}
  		Contact.order("last_name ASC").where("address_1 <> ''").each_with_index do |c, i|
  			next_row = i+1
  			salutation = c.spouse_name.blank? ? c.first_name : "#{c.first_name} & #{c.spouse_name}"
  			country = c.country.iso3.downcase == "usa" ? "" : c.country.printable_name.upcase
  			state = c.state.state_short.downcase == "ns" ? "" : c.state.state_short
  			worksheet.row(next_row).push "", cleaned(c.first_name), cleaned(c.last_name), cleaned(c.spouse_name), cleaned(c.family_name), cleaned(salutation), cleaned(c.address_1), cleaned(c.address_2), cleaned(c.city), state, c.zip, country, c.email
  		end
  		book.write File.join(Rails.root, 'reports', 'cten_contact_list.xls')
	end

	# Strip off , . # and '
	#
	def cleaned(txt)
		txt.gsub(/[(,\'.#)]/, '')
	end
	
end