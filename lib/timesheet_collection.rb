require './lib/timesheet'

class TimesheetCollection
  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def self.from_csv(data)
    timesheet_collection = data.each_with_object([]) do |row, arr|
      arr << Timesheet.new(row)
    end

    new(timesheet_collection)
  end

  def job_names
    collection.map(&:job).uniq
  end

  def employee_names
    collection.map(&:name).uniq
  end

  def filter_tsheets_by_employee(employee_name)
    collection.find_all { |tsheet| tsheet.name == employee_name }
  end

  def filter_tsheets_by_job(job_name)
    collection.find_all { |tsheet| tsheet.job == job_name }
  end

  def total_hours
    collection.map(&:hours).sum
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
    employee_hours_by_job(employee_name).transform_values do |job_hours|
      (job_hours / total_employee_hours(employee_name)).round(2)
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
    percentage_summary[job_names[0]] -= 0.01
    percentage_summary
  end
end
