require './lib/timesheet'
require './lib/timesheet_collection'

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

  describe '#filter_tsheets_by_job' do
    it 'filters timesheet collection by job' do
      expect(@tsheet_collection.filter_tsheets_by_job('86 Marine Road')).to eql([@tsheet1])
    end
  end

  describe '#filter_tsheets_by_job' do
    it 'filters timesheet collection by job' do
      expect(@tsheet_collection.filter_tsheets_by_job('86 Marine Road')).to eql([@tsheet1])
    end
  end

  describe '#total_hours' do
    it 'returns total number of employee hours' do
      expect(@tsheet_collection.total_hours).to eql(16.0)
    end
  end

  describe '#total_hours_by_job' do
    it 'returns hash of jobs and hours' do
      hash = { '14 Pompeii Street' => 8.0, '40 Boynton Road' => 2.0, '86 Marine Road' => 6.0 }
      expect(@tsheet_collection.total_hours_by_job).to eql(hash)
    end
  end

  describe '#total_employee_hours' do
    it 'returns the total number of hours for a particular employee' do
      expect(@tsheet_collection.total_employee_hours('Carlos')).to eql(8.0)
    end
  end

  describe '#employee_hours_by_job' do
    it 'returns the total number of hours by job for a particular employee' do
      hash = { '40 Boynton Road' => 2.0, '86 Marine Road' => 6.0 }
      expect(@tsheet_collection.employee_hours_by_job('Carlos')).to eql(hash)
    end
  end

  describe '#employee_hours_summary' do
    it 'returns a summary of each employees jobs/hours' do
      hash = {
        'Carlos' => { '40 Boynton Road' => 2.0, '86 Marine Road' => 6.0 },
        'Erikson' => { '14 Pompeii Street' => 8.0 }
      }
      expect(@tsheet_collection.employee_hours_summary).to eql(hash)
    end
  end

  describe '#employee_percentage_by_job' do
    it 'returns the % worked by job for a particular employee' do
      hash = { '40 Boynton Road' => 0.25, '86 Marine Road' => 0.75 }
      expect(@tsheet_collection.employee_percentage_by_job('Carlos')).to eql(hash)
    end
  end

  describe '#edison_percentage_by_job' do
    it "returns Edison's percentage by jobs" do
      hash = { '14 Pompeii Street' => 0.5, '40 Boynton Road' => 0.13, '86 Marine Road' => 0.38 }
      expect(@tsheet_collection.edison_percentage_by_job).to eql(hash)
    end
  end

  describe '#employee_percentage_summary' do
    it 'returns summary of each employee and their percentage by job' do
      hash = {
        'Carlos' => { '40 Boynton Road' => 0.25, '86 Marine Road' => 0.75 },
        'Erikson' => { '14 Pompeii Street' => 1.0 }
      }
      expect(@tsheet_collection.employee_percentage_summary).to eql(hash)
    end
  end

  describe '#employee_percentage_summary_with_edison' do
    it 'returns summary of each employee AND Edison and their percentage by job' do
      hash = {
        'Carlos' => { '40 Boynton Road' => 0.25, '86 Marine Road' => 0.75 },
        'Edison' => { '14 Pompeii Street' => 0.5, '40 Boynton Road' => 0.13, '86 Marine Road' => 0.37 },
        'Erikson' => { '14 Pompeii Street' => 1.0 }
      }
      expect(@tsheet_collection.employee_percentage_summary_with_edison).to eql(hash)
    end
  end

  describe '#percentage_total_greater_than_1?' do
    it 'checks if the sum of job percentages is greater than 1' do
      hash = { '14 Pompeii Street' => 0.5, '40 Boynton Road' => 0.13, '86 Marine Road' => 0.38 }
      expect(@tsheet_collection.percentage_total_greater_than_1?(hash)).to be true
    end
  end
end
