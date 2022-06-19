# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Orientation do
  let(:cardinal_direction) { 'NORTH' }
  subject(:validate_cardinal_direction) { described_class.validate_cardinal_direction(cardinal_direction) }

  describe '#validate_cardinal_direction' do
    it 'returns with no exception' do
      expect { validate_cardinal_direction }.to_not raise_error
    end

    context 'the orientation provided does not exist' do
      let(:cardinal_direction) { 'SOUTHEAST' }
      it 'raises an exception' do
        expect { validate_cardinal_direction }.to raise_error(
          Orientation::NonExistentCardinalDirectionError,
          'Error: Cardinal direction does not exist.'
        )
      end
    end
  end

  subject(:orientation) { Orientation.new(cardinal_direction:) }
  let(:cardinal_direction) { 'EAST' }

  describe '.rotate' do
    context 'rotating left' do
      let(:direction) { 'LEFT' }
      it 'returns a value to the left of the current cardinal direction' do
        orientation.rotate(direction)
        expect(orientation.cardinal_direction).to eq('NORTH')
      end
      context 'current cardinal direction is start of array (first element)' do
        let(:cardinal_direction) { 'NORTH' }
        it 'returns a value to the left of the current cardinal direction' do
          orientation.rotate('LEFT')
          expect(orientation.cardinal_direction).to eq('WEST')
        end
      end
    end

    context 'rotating right' do
      let(:direction) { 'RIGHT' }
      it 'returns a value to the right of the current cardinal direction' do
        orientation.rotate(direction)
        expect(orientation.cardinal_direction).to eq('SOUTH')
      end
      context 'current cardinal direction is end of array (last element)' do
        let(:cardinal_direction) { 'WEST' }
        it 'returns a value to the left of the current cardinal direction' do
          orientation.rotate(direction)
          expect(orientation.cardinal_direction).to eq('NORTH')
        end
      end
    end
  end
end
