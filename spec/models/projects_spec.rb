require 'spec_helper'

describe Project do
  it { should have_many(:report_cards) }
  it { validate_uniqueness_of(:project_name) }

  before do
    Project.create( team: 'Business Data', 
                    project_name: 'team',
                    hours: 5,
                    delivery_date: DateTime.now,
                    spoilage: 5,
                    accuracy: 12,
                    complexity: 'hard',
                    project_number: '3')
  end

  describe ".biz_data_project_chart_arrays" do
    let(:projects) { Project.where(team: 'Business Data') }

    # it "calls the expected methods" do
    #   described_class.should_receive(:create_spoilage_array)
    #   described_class.biz_data_project_chart_arrays
    # end


    before do
      described_class.should_receive(:create_spoilage_array).with(projects).and_return(1)
    end

    it "returns hash with proper keys" do
      expect(described_class.biz_data_project_chart_arrays).to eq({spoilage: 1})
    end

  end

  describe "create_spoilage_array" do
    let(:projects) { Project.all }

    
    it "returns expected array" do
      response = described_class.send(:create_spoilage_array, projects)
      expect(response[0].length).to eq(2)

    end
  end
end
