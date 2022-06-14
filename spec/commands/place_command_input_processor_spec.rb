# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PlaceCommandInputProcessor do
  subject(:place_command_input_processor) { PlaceCommandInputProcessor.new.perform(input) }

  let(:input) { 'PLACE 10,20,NORTH' }
  let(:x_coordinate) { 10 }
  let(:y_coordinate) { 20 }
  let(:cardinal_direction) { 'NORTH' }

  describe '.perform' do
    it 'extracts position from place command arguments' do
      place_command_input_processor
      expect(place_command_input_processor.x_coordinate).to eq(x_coordinate)
      expect(place_command_input_processor.y_coordinate).to eq(y_coordinate)
    end

    it 'extracts orientation from place command arguments' do
      place_command_input_processor
      expect(place_command_input_processor.cardinal_direction).to eq(cardinal_direction)
    end

    context 'Place command includes no arguments' do
      let(:input) { 'PLACE' }
      it 'raises an input validation error with appropriate message' do
        expect { place_command_input_processor }.to raise_error(
          PlaceCommandInputProcessor::InputValidationError,
          'Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F'
        )
      end
    end

    context 'Place command missing orientation' do
      let(:input) { 'PLACE 10,20' }
      it 'raises an input validation error with appropriate message' do
        expect { place_command_input_processor }.to raise_error(
          PlaceCommandInputProcessor::InputValidationError,
          'Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F'
        )
      end
    end

    context 'Place command does not include two coordinates' do
      let(:input) { 'PLACE 10,NORTH' }
      it 'raises an input validation error with appropriate message' do
        expect { place_command_input_processor }.to raise_error(
          PlaceCommandInputProcessor::InputValidationError,
          'Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F'
        )
      end
    end

    context 'Place command missing space after PLACE' do
      let(:input) { 'PLACE10,10,NORTH' }
      it 'raises an input validation error with appropriate message' do
        expect { place_command_input_processor }.to raise_error(
          PlaceCommandInputProcessor::InputValidationError,
          'Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F'
        )
      end
    end

    context 'Place command includes 3 coordinates' do
      let(:input) { 'PLACE 10,20,30,NORTH' }
      it 'raises an input validation error with appropriate message' do
        expect { place_command_input_processor }.to raise_error(
          PlaceCommandInputProcessor::InputValidationError,
          'Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F'
        )
      end
    end

    context 'Coordinates provided are not integers' do
      let(:input) { 'PLACE x,y,NORTH' }
      it 'raises an input validation error with appropriate message' do
        expect { place_command_input_processor }.to raise_error(
          PlaceCommandInputProcessor::InputValidationError,
          'Error: X and Y coordinates must be integers. Expected format is PLACE INT,INT,STRING'
        )
      end
    end

    context 'Only one of the coordinates provided is an integer' do
      let(:input) { 'PLACE 1,y,NORTH' }
      it 'raises an input validation error with appropriate message' do
        expect { place_command_input_processor }.to raise_error(
          PlaceCommandInputProcessor::InputValidationError,
          'Error: X and Y coordinates must be integers. Expected format is PLACE INT,INT,STRING'
        )
      end
    end
  end
end
