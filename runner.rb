require 'csv'
require './lib/timesheet_collection'

data = CSV.read('./data/payroll_9_25_20.csv', headers: true, header_converters: :symbol)
payroll_data = TimesheetCollection.from_csv(data)

# pp payroll_data.job_names
# pp payroll_data.employee_names
# pp payroll_data.tot_hours('Carlos')
# pp payroll_data.tsheets_by_employee('Carlos')
# pp payroll_data.hours_by_job('Carlos')
# pp payroll_data.percentage_by_job('Carlos')
pp payroll_data.employee_percentage_by_job

# TODO
# Add Edison to #employee_percentage_by_location_hash
# Order employee_percentage_by_location_hash by the way info is input into QB
# Provide payroll data and calculate splits automatically
# Use ARGV to accept file
