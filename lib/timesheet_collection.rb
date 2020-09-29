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

  def location_names
    collection.each_with_object([]) do |tsheet, arr|
      arr << tsheet.location unless arr.include?(tsheet.location)
    end
  end

  def employee_names
    collection.each_with_object([]) do |tsheet, arr|
      arr << tsheet.name unless arr.include?(tsheet.name)
    end
  end

  def tot_hours(employee_name)
    tsheets_by_employee(employee_name).map(&:hours).sum
  end

  def employee_percentage_by_location
    employee_names.each_with_object({}) do |name, hash|
      hash[name] = percentage_by_location(name)
    end
  end

  def tsheets_by_employee(employee_name)
    collection.find_all { |tsheet| tsheet.name == employee_name }
  end

  def hours_by_location(employee_name)
    tsheets_by_employee(employee_name).each_with_object({}) do |tsheet, hash|
      hash.default = 0
      hash[tsheet.location] += tsheet.hours
    end
  end

  def percentage_by_location(employee_name)
    location_hours = hours_by_location(employee_name)
    total_hours = tot_hours(employee_name)

    location_names.each_with_object({}) do |location_name, hash|
      hash[location_name] = (location_hours[location_name] / total_hours).round(2)
    end
  end
end
