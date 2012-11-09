db_adapter = ActiveRecord::Base.configurations[Rails.env]['adapter']
if (db_adapter=='sqlite3')
  DATE_MONTH_STRFTIME = "strftime('%m', COLUMN)"
  DATE_YEAR_STRFTIME = "strftime('%Y', COLUMN)"
elsif db_adapter["mysql"]
  DATE_MONTH_STRFTIME = "extract(month from COLUMN)"
  DATE_YEAR_STRFTIME = "extract(year  from COLUMN)"
else
  puts "insert rails error"
end