# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Orientation do
  let(:validate_cardinal_direction) { described_class.validate_cardinal_direction(cardinal_direction) }
  let(:cardinal_direction) { 'NORTH' }

  describe '#validate_cardinal_direction' do
    it 'returns with no exception' do
      expect { validate_cardinal_direction }.to_not raise_error(
        Orientation::NonExistentCardinalDirectionError,
        'Error: Cardinal direction does not exist.'
      )
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
end
