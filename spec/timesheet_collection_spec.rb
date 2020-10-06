require './lib/timesheet'
require './lib/timesheet_collection'
require 'csv'

describe 'TimesheetCollection' do
  let(:data) { CSV.read('./data/dummy_hours.csv', headers: true, header_converters: :symbol) }
  subject { TimesheetCollection.from_csv(data) }

  describe '#init' do
    it 'is an instance of TimesheetCollection' do
      is_expected.to be_an_instance_of TimesheetCollection
    end

    it 'has a collection' do
      expect(subject.collection.length).to eql(6)
    end
  end

  describe '#job_names' do
    it 'provides a list of job names' do
      expect(subject.job_names).to eql(%w[86 215 40Boyn])
    end
  end

  describe '#employee_names' do
    it 'provides a list of employee names' do
      expect(subject.employee_names).to eql(%w[Carlos Erikson Stevan])
    end
  end

  # describe '#filter_tsheets_by_employee' do
  #   it 'filters timesheet collection by employee' do
  #     tsheet1 = Timesheet.new(;)
  #     expect(subject.filter_tsheets_by_employee('Carlos')).to eql([#<Timesheet:0x00007fdba09feba0 @name="Carlos", @hours=7.5, @job="86">, #<Timesheet:0x00007fdba09fe9c0 @name="Carlos", @hours=6.5, @job="215">])
  #   end
  # end
end
