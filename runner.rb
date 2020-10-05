require 'csv'
require './lib/timesheet_collection'
require './lib/report_formatter'

data = CSV.read(ARGV[0], headers: true, header_converters: :symbol)
timesheet_data = TimesheetCollection.from_csv(data)
timesheet_report = timesheet_data.employee_percentage_summary_with_edison
formatter = ReportFormatter.new(timesheet_report)

File.open('text/timesheet_report.txt', 'w').write(formatter.format_report)

# pp timesheet_data.job_names
# pp timesheet_data.employee_names
# pp timesheet_data.tot_hours_by_employee('Carlos')
# pp timesheet_data.tot_hours_by_employee('Stevan')
# pp timesheet_data.tot_hours_by_employee('Erikson')
# pp timesheet_data.tsheets_by_employee('Carlos')
# pp timesheet_data.hours_by_job('Carlos')
# pp timesheet_data.percentage_by_job('Carlos')
# pp timesheet_data.employee_hours_summary
# pp timesheet_data.employee_percentage_by_job_all
# pp timesheet_data.total_hours
# pp timesheet_data.total_hours_by_job
# pp timesheet_data.edison_percentage_by_job

# pp timesheet_data.employee_hours_by_job2

# TODO
# Order employee_percentage_by_location_hash by the way info is input into QB
# Provide payroll data and calculate splits automatically
# Use ARGV to accept file
# Format output
# Write calculation output to file or excel
