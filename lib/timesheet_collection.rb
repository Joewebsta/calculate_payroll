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
    employee_names.each_with_object({}) do |name, hash|
      hash[name] = employee_hours_by_job(name)
    end
  end

  def employee_percentage_by_job(employee_name)
    employee_hours_by_job(employee_name).transform_values do |job_hours|
      (job_hours / total_employee_hours(employee_name)).round(2)
    end
  end

  def employee_percentage_summary
    employee_names.each_with_object({}) do |name, hash|
      hash[name] = employee_percentage_by_job(name)
    end
  end

  def total_hours
    collection.map(&:hours).sum
  end

  def total_hours_by_job
    job_names.each_with_object({}) do |job_name, hash|
      hash[job_name] = collection.select { |tsheet| tsheet.job == job_name }.map(&:hours).sum
    end
  end

  def edison_percentage_by_job
    job_names.each_with_object({}) do |name, hash|
      hash[name] = (total_hours_by_job[name] / total_hours).round(2)
    end
  end

  def employee_percentage_by_job_all
    hash = employee_percentage_by_job
    hash['Edison'] = edison_percentage_by_job
    hash
  end
end
