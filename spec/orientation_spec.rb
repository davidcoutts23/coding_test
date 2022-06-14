# frozen_string_literal: true

require 'orientation'

RSpec.describe Orientation do
  let(:cardinal_direction) { 'NORTH' }

  describe '#exist?' do
    it 'returns true' do
      expect(described_class.exist?(cardinal_direction)).to be(true)
    end

    context 'the orientation provided does not exist' do
      let(:cardinal_direction) { 'SOUTHEAST' }
      it 'returns false' do
        expect(described_class.exist?(cardinal_direction)).to be(false)
      end
    end
  end
end
