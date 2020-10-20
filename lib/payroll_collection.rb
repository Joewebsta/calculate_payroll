require './lib/payroll'

class PayrollCollection
  attr_reader :payroll_collection

  def initialize(collection)
    @payroll_collection = collection
  end

  def self.from_csv(payroll_data)
    payroll_collection = payroll_data.each_with_object([]) do |payroll_row, payroll_array|
      payroll_array << Payroll.new(payroll_row)
    end

    new(payroll_collection)
  end

  def filter_payroll_by_employee(employee_name)
    payroll_collection.find { |payroll| payroll.name == employee_name }
  end
end
