class ReportFormatter
  attr_reader :timesheet_report

  def initialize(timesheet_report)
    @timesheet_report = timesheet_report
  end

  def format_report
    timesheet_report.reduce('') do |output_string, employee|
      output_string += format_employee_name(employee[0])
      output_string + format_employee_job(employee[1]) + "\n"
    end
  end

  def format_employee_name(employee_name)
    employee_name.upcase + "\n"
  end

  def format_employee_job(job_obj)
    job_obj.reduce('') do |string, job|
      job_name = job[0]
      job_percentage = job[1]

      string + "#{job_name}: #{job_percentage} \n"
    end
  end
end