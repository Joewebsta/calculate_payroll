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
end
