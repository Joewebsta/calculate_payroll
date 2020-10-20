require 'csv'
require './lib/timesheet_collection'
require './lib/payroll_collection'
require './lib/report_formatter'

timesheet_data = CSV.read(ARGV[0], headers: true, header_converters: :symbol)
payroll_data = CSV.read(ARGV[1], headers: true, header_converters: :symbol)

payroll_collection = PayrollCollection.from_csv(payroll_data)
timesheet_collection = TimesheetCollection.from_csv(timesheet_data)

# timesheet_report = timesheet_collection.employee_percentage_summary_with_edison
# formatter = ReportFormatter.new(timesheet_report)
# File.open('text/timesheet_report.txt', 'w').write(formatter.format_report)

# TEST CODE
# pp timesheet_collection.employee_hours_summary
# pp timesheet_collection.employee_percentage_by_job('Carlos')
# pp timesheet_collection.employee_payroll_by_job('Carlos')
# pp payroll_data
# pp timesheet_collection.employee_payroll_by_job('Carlos', payroll_collection)
pp timesheet_collection.employee_payroll_summary(payroll_collection)

# TODO
# give jobs an id so they are orded consitently in output text file
# Order employee_percentage_by_location_hash by the way info is input into QB
# include all jobs for each employee so the output text is consistent (same number of rows per employee)
# Change order of employees in output text so it is consitent with quickbooks entry
# Provide payroll data and calculate splits automatically
# Write calculation output to file or excel

# COMPLETED
# sum the percentages to see if they equal 1.0 or greater
# format output text so there are columns
# Use ARGV to accept file
# Format output
