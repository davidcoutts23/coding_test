# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Movement do
  subject(:movement) { Movement.new }

  # 0, 0 represents the southwest most position on the tabletop
  let(:position_input) do
    instance_double(Position,
                    x_coordinate: 0,
                    y_coordinate: 0)
  end

  let(:orientation_input) do
    instance_double(Orientation,
                    cardinal_direction:)
  end

  let(:position_output) do
    instance_double(Position,
                    x_coordinate: x_coordinate_output,
                    y_coordinate: y_coordinate_output)
  end

  describe '.move' do
    context 'move north' do
      let(:cardinal_direction) { 'NORTH' }
      let(:x_coordinate_output) { 0 }
      let(:y_coordinate_output) { 1 }
      it 'creates a new position with y_coordinate incremented by 1' do
        expect(Position).to receive(:new).with(x_coordinate: x_coordinate_output, y_coordinate: y_coordinate_output)
        movement.move(position: position_input, orientation: orientation_input)
      end
    end

    context 'move south' do
      let(:cardinal_direction) { 'SOUTH' }
      let(:x_coordinate_output) { 0 }
      let(:y_coordinate_output) { -1 }
      it 'creates a new position with y_coordinate decremented by 1' do
        expect(Position).to receive(:new).with(x_coordinate: x_coordinate_output, y_coordinate: y_coordinate_output)
        movement.move(position: position_input, orientation: orientation_input)
      end
    end

    context 'move east' do
      let(:cardinal_direction) { 'EAST' }
      let(:x_coordinate_output) { 1 }
      let(:y_coordinate_output) { 0 }
      it 'creates a new position with x_coordinate incremented by 1' do
        expect(Position).to receive(:new).with(x_coordinate: x_coordinate_output, y_coordinate: y_coordinate_output)
        movement.move(position: position_input, orientation: orientation_input)
      end
    end

    context 'move west' do
      let(:cardinal_direction) { 'WEST' }
      let(:x_coordinate_output) { -1 }
      let(:y_coordinate_output) { 0 }
      it 'creates a new position with x_coordinate incremented by 1' do
        expect(Position).to receive(:new).with(x_coordinate: x_coordinate_output, y_coordinate: y_coordinate_output)
        movement.move(position: position_input, orientation: orientation_input)
      end
    end
  end
end
