# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RotateCommand do
  subject(:rotate_command) { RotateCommand.new(tabletop:, robot:) }

  let(:robot) { instance_double(Robot) }
  let(:tabletop) { instance_double(Tabletop) }
  let(:direction) { 'LEFT' }

  before(:each) do
    allow(robot).to receive(:execute_rotation).with(direction)
  end

  describe '.perform' do
    it 'updates the robot orientation to the orientation as calculated by the robots rotation action' do
      expect(robot).to receive(:execute_rotation).with(direction)
      rotate_command.perform(direction)
    end
    it 'sets an result informing that the robot has been rotated' do
      rotate_command.perform(direction)
      expect(rotate_command.result).to eq("Robot has been rotated #{direction}")
    end
  end
end
