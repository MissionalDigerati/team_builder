db_adapter = ActiveRecord::Base.configurations[Rails.env]['adapter']
if (db_adapter=='sqlite3')
  DATE_DAY_STRFTIME = "strftime('%d', COLUMN)"
  DATE_MONTH_STRFTIME = "strftime('%m', COLUMN)"
  DATE_YEAR_STRFTIME = "strftime('%Y', COLUMN)"
  DATE_MONTH_DAY_ORDER_STRFTIME = "strftime('%d %m', COLUMN) DIRECTION"
elsif db_adapter["mysql"]
  DATE_DAY_STRFTIME = "extract(day from COLUMN)"
  DATE_MONTH_STRFTIME = "extract(month from COLUMN)"
  DATE_YEAR_STRFTIME = "extract(year  from COLUMN)"
  DATE_MONTH_DAY_ORDER_STRFTIME = "extract(month from COLUMN) DIRECTION, extract(day from COLUMN) DIRECTION"
else
  puts "insert rails error"
end