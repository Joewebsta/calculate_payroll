require './lib/timesheet'

describe 'Timesheet' do
  subject { Timesheet.new({ firstname: 'Carlos', total_hours: '6', location_name: '86 Marine Road' }) }

  describe '#init' do
    it 'is an instance of Timesheet' do
      is_expected.to be_an_instance_of Timesheet
    end

    it 'has a name' do
      expect(subject.name).to eql('Carlos')
    end

    it 'has hours' do
      expect(subject.hours).to eql(6.0)
    end

    it 'has a job' do
      expect(subject.job).to eql('86 Marine Road')
    end
  end
end
