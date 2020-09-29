require 'csv'
require './lib/timesheet_collection'

data = CSV.read('./data/payroll_9_25_20.csv', headers: true, header_converters: :symbol)
payroll_data = TimesheetCollection.from_csv(data)

# pp payroll_data.calc_tot_hours_by_employee
# pp payroll_data.tsheets_by_employee('Carlos')
# pp payroll_data.hours_by_location('Carlos')
pp payroll_data.employee_hours_by_job

#  Open file
#  Convert to csv object
#  Loop through csv object rows --> convert rows into Timesheet objects
#  Create array of timesheet objects to manipulate
