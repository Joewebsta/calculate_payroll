class Timesheet
  attr_reader :name,
              :hours,
              :job

  def initialize(data)
    @name = data[:firstname]
    @hours = data[:total_hours].to_f
    @job = data[:location_name]
  end
end
