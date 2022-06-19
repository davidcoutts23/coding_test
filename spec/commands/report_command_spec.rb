# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ReportCommand do
  subject(:report_command) { ReportCommand.new(tabletop:, robot:) }

  let(:robot) { instance_double(Robot) }
  let(:tabletop) { instance_double(Tabletop) }

  before(:each) do
    allow(robot).to receive(:report).and_return('Output: 0,1,NORTH')
  end

  describe '.perform' do
    it 'reports the robots position and orientation' do
      report_command.perform
      expect(report_command.result).to eq('Output: 0,1,NORTH')
    end
  end
end
