require 'csv'
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
	
	desc "Take Monthly Report and create Moneywell import"
		task :monthly_report_convert, [:csv_file_path, :date_of_deposit] => :environment do |t, args|
			deposit_date = (args[:date_of_deposit].nil? || args[:date_of_deposit] == "") ? Date.today : args[:date_of_deposit]
			if args[:csv_file_path].nil? || args[:csv_file_path] == ""
				puts "Please supply the path from Rails.root to the CTEN Monthly Report CSV\r\n"
				puts "ex. rake cten:monthly_report_convert[csv/money_reports/june_data.CSV]"
			else
				file_to_read = File.join(Rails.root, args[:csv_file_path])
				if File.exists?(file_to_read)
					line_read = 0
					rows = Array.new
					missing_accounts = Array.new
					File.open(file_to_read).readlines.each do |line|
						if line_read > 0
							d = line.split(",")
							account = cleaned(d[2])
							contact_info = Contact.where(account_number: account).first
							if contact_info.nil?
								missing_accounts << "#{d[5]} - #{account}"
							else
								gift = d[13].gsub(/[(,\'#)]/, '').to_f
								gift_pretty = "%5.2f" % gift
								cten_portion = gift*0.07
								cten_portion_pretty = "%5.2f" % cten_portion
								final_gift = gift-cten_portion
								final_gift_pretty = "%5.2f" % final_gift
								rows << [deposit_date, "Deposit", "Contact ##{contact_info.id}", "CTEN $#{cten_portion_pretty}", "Donations for Pulos'", final_gift_pretty]
							end
						end
						line_read+= 1
					end
					
					unless missing_accounts.empty?
						puts "These accounts are missing from Team Builder.  Please run this script again once you fixed them."
						puts missing_accounts
					end
					
					final_file = File.join(Rails.root, "csv", 'moneywell.csv')
					CSV.open(final_file, "wb") do |csv|
						rows.each do |r|
							csv << r
						end
					end
				else
					puts "Please provide a valid CSV file"
				end
			end
		end
		
		desc "Take Monthly Report and save Donations in Team Builder"
			task :monthly_report_save, [:csv_file_path] => :environment do |t, args|
				if args[:csv_file_path].nil? || args[:csv_file_path] == ""
					puts "Please supply the path from Rails.root to the CTEN Monthly Report CSV\r\n"
					puts "ex. rake cten:monthly_report_save[csv/money_reports/june_data.CSV]"
				else
					file_to_read = File.join(Rails.root, args[:csv_file_path])
					if File.exists?(file_to_read)
						line_read = 0
						missing_accounts = Array.new
						File.open(file_to_read).readlines.each do |line|
							if line_read > 0
								d = line.split(",")
								account = cleaned(d[2])
								contact_info = Contact.where(account_number: account).first
								if contact_info.nil?
									missing_accounts << "#{d[5]} - #{account}"
								else
									gift = d[13].gsub(/[(,\'#)]/, '').to_f
									donation = {amount: gift, project: "Donations for Pulos'", donation_date: Date.strptime(d[10], '%m/%d/%Y')}
									new_donation = contact_info.donations.new(donation)
									puts new_donation.donation_date
									if new_donation.save
										puts "Saved a donation for #{contact_info.family_name} in Team Builder"
									else
										puts "Could not save a donation for #{contact_info.family_name} in Team Builder for #{gift_pretty}"
									end
								end
							end
							line_read+= 1
						end

						unless missing_accounts.empty?
							puts "These accounts are missing from Team Builder.  Please run this script again once you fixed them."
							puts missing_accounts
						end
					else
						puts "Please provide a valid CSV file"
					end
				end
			end

	# Strip off , . # and '
	#
	def cleaned(txt)
		txt.gsub(/[(,\'.#)]/, '')
	end
	
end