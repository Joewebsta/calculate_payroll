class ReportFormatter
  attr_reader :payroll_by_job_report

  def initialize(data)
    @payroll_by_job_report = data
  end

  def format_report
    # timesheet_report.reduce('') do |output_string, employee|
    #   output_string += format_employee_name(employee[0])
    #   output_string + format_employee_job(employee[1]) + "\n"
    # end.chomp
    payroll_by_job_report
  end

  def format_employee_name(employee_name)
    employee_name.upcase + "\n"
  end

  def format_employee_job(job_obj)
    job_obj.reduce('') do |string, job|
      job_name = (job[0] + ':').ljust(28)
      job_percentage = job[1].to_s.ljust(4, '0')

      string + "#{job_name} #{job_percentage} \n"
    end
  end
end
