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

  def calc_tot_employee_hours
    collection.each_with_object({}) do |tsheet, hash|
      hash.default = 0
      hash[tsheet.name] += tsheet.hours
    end
  end
end

# {
#   carlos: {
#     '86 marine' => 10,
#     '53 columbia' => 15
#   }
# }
