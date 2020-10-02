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

  def tsheets_by_employee(employee_name)
    collection.find_all { |tsheet| tsheet.name == employee_name }
  end

  def tot_hours_by_employee(employee_name)
    tsheets_by_employee(employee_name).map(&:hours).sum
  end

  def employee_hours_by_job2
    employee_names.each_with_object({}) do |employee_name, employee_summary|
      employee_summary[employee_name] = hours_by_job2(employee_name)
    end
  end

  def hours_by_job2(employee_name)
    collection.each_with_object({}) do |tsheet, job_summary|
      job_summary.default = 0
      job_summary[tsheet.job] += tsheet.hours if tsheet.name == employee_name
    end
  end

  def hours_by_job(employee_name)
    tsheets_by_employee(employee_name).each_with_object({}) do |tsheet, hash|
      hash.default = 0
      hash[tsheet.job] += tsheet.hours
    end
  end

  def percentage_by_job(employee_name)
    job_hours = hours_by_job(employee_name)
    total_hours = tot_hours_by_employee(employee_name)

    job_names.each_with_object({}) do |job_name, hash|
      hash[job_name] = (job_hours[job_name] / total_hours).round(2)
    end
  end

  def employee_hours_by_job
    employee_names.each_with_object({}) do |name, hash|
      hash[name] = hours_by_job(name)
    end
  end

  def employee_percentage_by_job
    employee_names.each_with_object({}) do |name, hash|
      hash[name] = percentage_by_job(name)
    end
  end

  def tot_hours
    employee_names.reduce(0) do |sum, name|
      sum + tot_hours_by_employee(name)
    end
  end

  def tot_hours_by_job
    job_names.each_with_object({}) do |job_name, hash|
      hash[job_name] = collection.select { |tsheet| tsheet.job == job_name }.map(&:hours).sum
    end
  end

  def edison_percentage_by_job
    job_names.each_with_object({}) do |name, hash|
      hash[name] = (tot_hours_by_job[name] / tot_hours).round(2)
    end
  end

  def employee_percentage_by_job_all
    hash = employee_percentage_by_job
    hash['Edison'] = edison_percentage_by_job
    hash
  end
end
