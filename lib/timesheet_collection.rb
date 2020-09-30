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
    collection.each_with_object([]) do |tsheet, arr|
      arr << tsheet.job
    end.uniq
  end

  def employee_names
    collection.each_with_object([]) do |tsheet, arr|
      arr << tsheet.name
    end.uniq
  end

  def tsheets_by_employee(employee_name)
    collection.find_all { |tsheet| tsheet.name == employee_name }
  end

  def tot_hours(employee_name)
    tsheets_by_employee(employee_name).map(&:hours).sum
  end

  def hours_by_job(employee_name)
    tsheets_by_employee(employee_name).each_with_object({}) do |tsheet, hash|
      hash.default = 0
      hash[tsheet.job] += tsheet.hours
    end
  end

  def percentage_by_job(employee_name)
    job_hours = hours_by_job(employee_name)
    total_hours = tot_hours(employee_name)

    job_names.each_with_object({}) do |job_name, hash|
      hash[job_name] = (job_hours[job_name] / total_hours).round(2)
    end
  end

  def employee_percentage_by_job
    employee_names.each_with_object({}) do |name, hash|
      hash[name] = percentage_by_job(name)
    end
  end
end
