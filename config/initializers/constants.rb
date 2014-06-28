db_adapter = ActiveRecord::Base.configurations[Rails.env]['adapter']
if (db_adapter=='sqlite3')
  DATE_MONTH_STRFTIME = "strftime('%m', COLUMN)"
  DATE_YEAR_STRFTIME = "strftime('%Y', COLUMN)"
  DATE_MONTH_DAY_ORDER_STRFTIME = "strftime('%m%d', COLUMN) DIRECTION"
  DATE_YEAR_ORDER_STRFTIME = "strftime('%Y', COLUMN) DIRECTION"
  DATE_YEAR_AS_INTEGER = "CAST(strftime('%Y', COLUMN) AS integer)"
elsif db_adapter["mysql"]
  DATE_MONTH_STRFTIME = "extract(month from COLUMN)"
  DATE_YEAR_STRFTIME = "extract(year  from COLUMN)"
  DATE_MONTH_DAY_ORDER_STRFTIME = "extract(month from COLUMN) DIRECTION, extract(day from COLUMN) DIRECTION"
  DATE_YEAR_ORDER_STRFTIME = "extract(year from COLUMN) DIRECTION"
  DATE_YEAR_AS_INTEGER = "CAST(strftime('%Y', COLUMN) AS integer)"
else
  puts "insert rails error"
end