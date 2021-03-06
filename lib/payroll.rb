class Payroll
  attr_reader :name,
              :gross,
              :net,
              :garnishment,
              :ee_taxes,
              :er_taxes,
              :gross_er_sum

  def initialize(data)
    @name = data[:first_name] || 'Totals'
    @gross = data[:gross_earnings].to_f
    @net = data[:net_pay].to_f
    @garnishment = data[:garnishment].to_f
    @ee_taxes = data[:employee_taxes].to_f
    @er_taxes = data[:employer_taxes].to_f
    @gross_er_sum = (@gross + @er_taxes).round(2)
  end
end
