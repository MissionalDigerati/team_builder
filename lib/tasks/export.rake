namespace :export do
	
	desc "Generate an Excel of all the contacts in Last Name ASC"
  task :contact_names => :environment do
  		book = Spreadsheet::Workbook.new
  		worksheet = book.create_worksheet :name => "Sheet 1"
  		worksheet.row(0).concat %w{Family}
  		Contact.order("last_name ASC").each_with_index do |c, i|
  			next_row = i+1
  			worksheet.row(next_row).push cleaned(c.family_name)
  		end
  		book.write File.join(Rails.root, 'reports', 'contact_list.xls')
	end

	# Strip off , . # and '
	#
	def cleaned(txt)
		txt.gsub(/[(,\'.#)]/, '')
	end
	
end