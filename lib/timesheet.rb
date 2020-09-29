class Timesheet
  attr_reader :name,
              :hours,
              :location

  def initialize(data)
    @name = data[:employee_name]
    @hours = data[:total_hours].to_f
    @location = data[:location_name]
  end
end
