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

  def calc_tot_hours_by_employee
    collection.each_with_object({}) do |tsheet, hash|
      hash.default = 0
      hash[tsheet.name] += tsheet.hours
    end
  end

  def calc_tot_job_hours_by_employee; end

  def calc_employee_hours_by_job; end

  def tsheets_by_employee(employee_name)
    collection.find_all { |tsheet| tsheet.name == employee_name }
  end

  def hours_by_location(employee_name)
    tsheets_by_employee(employee_name).each_with_object({}) do |tsheet, hash|
      hash.default = 0
      hash[tsheet.location] += tsheet.hours
    end
  end

  # def hours_by_job
  #   collection.each_with_object({}) do |tsheet, hash|
  #     hash[tsheet.name] = { tsheet.location => tsheet.hours }
  #   end
  # end
end

# {
#   carlos: {
#     '86 marine' => 10,
#     '53 columbia' => 15
#   }
# }
