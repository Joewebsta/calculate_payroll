require 'csv'

data = CSV.read('./data/payroll_9_25_20.csv', headers: true, header_converters: :symbol)
data.each { |row| p row }

#  Open file
#  Convert to csv object
#  Loop through csv object rows --> convert rows into Timesheet objects
#  Create array of timesheet objects to manipulate
