require './lib/timesheet'

class TimesheetCollection
  attr_reader :timesheet_collection

  def initialize(timesheet_collection)
    @timesheet_collection = timesheet_collection
  end

  def self.from_csv(data)
    timesheet_collection = data.each_with_object([]) do |row, arr|
      arr << Timesheet.new(row)
    end

    new(timesheet_collection)
  end

  def add_payroll_collection(payroll_collection); end

  def job_names
    timesheet_collection.map(&:job).uniq
  end

  def employee_names
    timesheet_collection.map(&:name).uniq
  end

  def filter_tsheets_by_employee(employee_name)
    timesheet_collection.find_all { |tsheet| tsheet.name == employee_name }
  end

  def filter_tsheets_by_job(job_name)
    timesheet_collection.find_all { |tsheet| tsheet.job == job_name }
  end

  def total_hours
    timesheet_collection.map(&:hours).sum
  end

  def total_hours_by_job
    job_names.each_with_object({}) do |job_name, hash|
      hash[job_name] = filter_tsheets_by_job(job_name).map(&:hours).sum
    end
  end

  def total_employee_hours(employee_name)
    filter_tsheets_by_employee(employee_name).map(&:hours).sum
  end

  def employee_hours_by_job(employee_name)
    filter_tsheets_by_employee(employee_name).each_with_object({}) do |tsheet, hash|
      hash.default = 0
      hash[tsheet.job] += tsheet.hours
    end
  end

  def employee_hours_summary
    employee_names.each_with_object({}) do |employee_name, hash|
      hash[employee_name] = employee_hours_by_job(employee_name)
    end
  end

  def employee_percentage_by_job(employee_name)
    percentages_by_job = employee_hours_by_job(employee_name).transform_values do |job_hours|
      (job_hours / total_employee_hours(employee_name)).round(2)
    end

    if percentage_total_greater_than_1?(percentages_by_job)
      percentages_by_job = adjust_summary_percentage(percentages_by_job)
    end

    percentages_by_job
  end

  def employee_payroll_by_job(employee_name, payroll_collection)
    employee_percentage_by_job(employee_name).transform_values do |job_percentage|
      employee_payroll = payroll_collection.filter_payroll_by_employee(employee_name)

      {
        net: (employee_payroll.net * job_percentage).round(2),
        garnishment: (employee_payroll.garnishment * job_percentage).round(2),
        ee_taxes: (employee_payroll.ee_taxes * job_percentage).round(2),
        er_taxes: (employee_payroll.er_taxes * job_percentage).round(2),
        expected_gross: employee_payroll.gross.round(2),
        actual_gross: employee_payroll.net + employee_payroll.garnishment + employee_payroll.ee_taxes
      }
    end
  end

  def edison_percentage_by_job
    job_names.each_with_object({}) do |job_name, hash|
      hash[job_name] = (total_hours_by_job[job_name] / total_hours).round(2)
    end
  end

  def employee_percentage_summary
    employee_names.each_with_object({}) do |employee_name, hash|
      hash[employee_name] = employee_percentage_by_job(employee_name)
    end
  end

  def employee_percentage_summary_with_edison
    summary = employee_percentage_summary
    edison_job_percentages = edison_percentage_by_job

    if percentage_total_greater_than_1?(edison_job_percentages)
      edison_job_percentages = adjust_summary_percentage(edison_job_percentages)
    end

    summary['Edison'] = edison_job_percentages
    summary
  end

  def percentage_total_greater_than_1?(percentage_summary)
    percentage_summary.values.sum > 1.0
  end

  def adjust_summary_percentage(percentage_summary)
    job_name = find_job_with_largest_percentage(percentage_summary)

    percentage_summary[job_name] -= 0.01
    percentage_summary
  end

  def find_job_with_largest_percentage(percentage_summary)
    percentage_summary.key(percentage_summary.values.max)
  end

  def employee_payroll_summary(payroll_collection)
    employee_names.each_with_object({}) do |employee_name, summary|
      summary[employee_name] = employee_payroll_by_job(employee_name, payroll_collection)
    end
  end
end
