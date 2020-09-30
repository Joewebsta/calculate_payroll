require 'csv'
require './lib/timesheet_collection'

data = CSV.read(ARGV[0], headers: true, header_converters: :symbol)
payroll_data = TimesheetCollection.from_csv(data)

# pp payroll_data.job_names
# pp payroll_data.employee_names
# pp payroll_data.tot_hours_by_employee('Carlos')
# pp payroll_data.tot_hours_by_employee('Stevan')
# pp payroll_data.tot_hours_by_employee('Erikson')
# pp payroll_data.tsheets_by_employee('Carlos')
# pp payroll_data.hours_by_job('Carlos')
# pp payroll_data.percentage_by_job('Carlos')
# pp payroll_data.employee_hours_by_job
pp payroll_data.employee_percentage_by_job_all
# pp payroll_data.tot_hours
# pp payroll_data.tot_hours_by_job
# pp payroll_data.edison_percentage_by_job

# TODO
# Order employee_percentage_by_location_hash by the way info is input into QB
# Provide payroll data and calculate splits automatically
# Use ARGV to accept file
# Format output
# Write calculation output to file or excel
