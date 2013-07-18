namespace :reports do
	
	desc "Generate a Progress Report on all Contacts"
  task :progress => :environment do
  		book = Spreadsheet::Workbook.new
  		worksheet = book.create_worksheet :name => "Progress"
  		worksheet.row(0).concat(['Contact ID', 'Family Name', 'Believer', 'Spouse Believer', 'Standing'])
  		Contact.order("id ASC").each_with_index do |c, i|
  			next_row = i+1
				spouse_believer = ""
				believer = c.believer ? "Yes" : "No"
				spouse_believer = c.spouse_believer ? "Yes" : "No" if c.spouse_name != ""
  			worksheet.row(next_row).push(c.id, cleaned(c.family_name), believer, spouse_believer, c.support_state.progress)
  		end
			worksheet_stats = book.create_worksheet :name => "Stats"
			worksheet_stats.row(0).concat(['State', 'Count'])
			["initial", "letter_sent", "contacting", "seen_presentation", "following_up", "one_time_gift", "monthly_gift", "not_giving", "no_response"].each_with_index do |s, i|
				next_row = i+1
  			worksheet_stats.row(next_row).push(s.gsub(/[(_)]/, ' ').titlecase, SupportState.count_by_progress(s.to_sym))
			end
  		book.write File.join(Rails.root, 'reports', 'progress_report.xls')
	end

	# Strip off , . # and '
	#
	def cleaned(txt)
		txt.gsub(/[(,\'.#)]/, '')
	end
	
end