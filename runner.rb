require 'csv'
require './lib/timesheet_collection'
require './lib/report_formatter'

data = CSV.read(ARGV[0], headers: true, header_converters: :symbol)
timesheet_data = TimesheetCollection.from_csv(data)
timesheet_report = timesheet_data.employee_percentage_summary_with_edison
# formatter = ReportFormatter.new(timesheet_report)

# File.open('text/timesheet_report.txt', 'w').write(formatter.format_report)

# pp timesheet_data.employee_hours_summary
pp timesheet_data.employee_percentage_by_job('Carlos')
pp timesheet_data.employee_payroll_by_job('Carlos')

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
