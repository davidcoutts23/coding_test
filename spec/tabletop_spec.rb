# frozen_string_literal: true

require 'spec_helper'
require 'rspec'
require 'tabletop'
require 'position'

RSpec.describe Tabletop do
  subject(:tabletop) { Tabletop.new(x_units: 5, y_units: 5) }
  let(:validate_position) { tabletop.validate_position(position) }

  let(:x_coordinate) { 3 }
  let(:y_coordinate) { 0 }
  let(:position) do
    instance_double(
      Position,
      x_coordinate:,
      y_coordinate:
    )
  end

  describe '.position_valid?' do
    it 'returns with no error raised' do
      expect { validate_position }.to_not raise_error
    end

    context 'an x coordinate provided is out of range (too high)' do
      let(:x_coordinate) { 5 }
      it 'raises an error' do
        expect { validate_position }.to raise_error(
          Tabletop::NonExistentTabletopPositionError,
          'Error: Position does not exist on the tabletop.'
        )
      end
    end

    context 'an x coordinate provided is out of range (too low)' do
      let(:x_coordinate) { -1 }
      it 'raises an error' do
        expect { validate_position }.to raise_error(
          Tabletop::NonExistentTabletopPositionError,
          'Error: Position does not exist on the tabletop.'
        )
      end
    end

    context 'a y coordinate provided is out of range (too high)' do
      let(:y_coordinate) { 5 }
      it 'raises an error' do
        expect { validate_position }.to raise_error(
          Tabletop::NonExistentTabletopPositionError,
          'Error: Position does not exist on the tabletop.'
        )
      end
    end

    context 'a y coordinate provided is out of range (too low)' do
      let(:y_coordinate) { -1 }
      it 'raises an error' do
        expect { validate_position }.to raise_error(
          Tabletop::NonExistentTabletopPositionError,
          'Error: Position does not exist on the tabletop.'
        )
      end
    end

    context 'both x and y coordinates provided are out of range' do
      let(:x_coordinate) { 5 }
      let(:y_coordinate) { 5 }
      it 'raises an error' do
        expect { validate_position }.to raise_error(
          Tabletop::NonExistentTabletopPositionError,
          'Error: Position does not exist on the tabletop.'
        )
      end
    end
  end
end
