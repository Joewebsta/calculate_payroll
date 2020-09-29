class Timesheet
  def initialize(data)
    @name = data[:employee_name]
    @hours = data[:total_hours]
    @location = data[:location_name]
  end
end
