require 'csv'
require './lib/timesheet_collection'

data = CSV.read('./data/payroll_9_25_20.csv', headers: true, header_converters: :symbol)
payroll_data = TimesheetCollection.from_csv(data)

# pp payroll_data.calc_tot_employee_hours
pp payroll_data.location_names

#  Open file
#  Convert to csv object
#  Loop through csv object rows --> convert rows into Timesheet objects
#  Create array of timesheet objects to manipulate
