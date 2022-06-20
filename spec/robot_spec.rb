# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Robot do
  subject(:robot) { Robot.new(position:, orientation:) }

  let(:position) { instance_double(Position, x_coordinate: 0, y_coordinate: 0) }
  let(:orientation) { instance_double(Orientation, cardinal_direction: 'NORTH') }
  let(:movement) { instance_double(Movement) }
  let(:rotation) { instance_double(Rotation) }
  let(:direction) { 'LEFT' }

  before(:each) do
    allow(Movement).to receive(:new).and_return(movement)
    allow(movement).to receive(:move).with(position:, orientation:).and_return(position)

    allow(Rotation).to receive(:new).and_return(rotation)
    allow(rotation).to receive(:rotate).with(direction:, orientation:)
  end

  describe '.calculate_move' do
    it 'sends a move message to movement with a position and orientation' do
      expect(movement).to receive(:move).with(position:, orientation:).and_return(position)
      robot.calculate_move
    end
  end

  describe '.execute_rotation' do
    it 'sends a rotate message to rotation with a direction' do
      expect(rotation).to receive(:rotate).with(direction:, orientation:)
      robot.execute_rotation(direction)
    end
  end

  describe '.report' do
    it 'returns a string representing the robots current position and orientation' do
      expect(robot.report).to eq("Output: #{position.x_coordinate},#{position.y_coordinate},#{orientation.cardinal_direction}")
    end
  end
end
