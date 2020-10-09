require './lib/timesheet'
require './lib/timesheet_collection'
require 'csv'

describe 'TimesheetCollection' do
  before do
    @tsheet1 = Timesheet.new({ firstname: 'Carlos', total_hours: '6', location_name: '86 Marine Road' })
    @tsheet2 = Timesheet.new({ firstname: 'Carlos', total_hours: '2', location_name: '40 Boynton Road' })
    @tsheet3 = Timesheet.new({ firstname: 'Erikson', total_hours: '8', location_name: '14 Pompeii Street' })
    @tsheet_collection = TimesheetCollection.new([@tsheet1, @tsheet2, @tsheet3])
  end

  describe '#init' do
    it 'is an instance of TimesheetCollection' do
      expect(@tsheet_collection).to be_an_instance_of TimesheetCollection
    end

    it 'has a collection' do
      expect(@tsheet_collection.collection.length).to eql(3)
    end
  end

  describe '#job_names' do
    it 'provides a list of job names' do
      expect(@tsheet_collection.job_names).to eql(['86 Marine Road', '40 Boynton Road', '14 Pompeii Street'])
    end
  end

  describe '#employee_names' do
    it 'provides a list of employee names' do
      expect(@tsheet_collection.employee_names).to eql(%w[Carlos Erikson])
    end
  end

  describe '#filter_tsheets_by_employee' do
    it 'filters timesheet collection by employee' do
      expect(@tsheet_collection.filter_tsheets_by_employee('Carlos')).to eql([@tsheet1, @tsheet2])
    end
  end
end
