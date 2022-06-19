# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MoveCommand do
  subject(:move_command) { MoveCommand.new(tabletop:, robot:) }

  let(:tabletop) { instance_double(Tabletop) }
  let(:robot) { instance_double(Robot) }
  let(:new_position) { instance_double(Position, x_coordinate: 0, y_coordinate: 0) }

  before(:each) do
    allow(robot).to receive(:calculate_move).and_return(new_position)
    allow(tabletop).to receive(:validate_position).with(new_position).and_return(nil)
    allow(robot).to receive(:position=).with(new_position)
  end

  describe '.perform' do
    it 'updates the robot position to the position as calculated by the robots move action' do
      expect(robot).to receive(:position=).with(new_position)
      move_command.perform
    end
    it 'sets an result informing that the robot has been moved' do
      move_command.perform
      expect(move_command.result).to eq("Robot moved to #{new_position.x_coordinate}, #{new_position.y_coordinate}")
    end

    context 'the tabletop position validator raises an error' do
      before(:each) do
        allow(tabletop).to receive(:validate_position).with(new_position) do
          raise Tabletop::NonExistentTabletopPositionError, 'Error: Position does not exist on the tabletop.'
        end
      end
      it 'does not update the robots position' do
        expect(robot).not_to receive(:position=).with(new_position)
        move_command.perform
      end
      it 'sets an result informing that that a non existent tabletop position error has occurred' do
        move_command.perform
        expect(move_command.result).to eq('Error: Position does not exist on the tabletop.')
      end
    end
  end
end
