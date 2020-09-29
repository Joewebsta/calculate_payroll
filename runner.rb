require 'csv'
require './lib/timesheet_collection'

data = CSV.read('./data/payroll_9_25_20.csv', headers: true, header_converters: :symbol)
payroll_data = TimesheetCollection.from_csv(data)

pp payroll_data.employee_percentage_by_location
