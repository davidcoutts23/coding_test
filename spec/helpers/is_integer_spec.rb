# frozen_string_literal: true

require './lib/helpers/is_integer'

RSpec.describe String do
  subject(:string) { '10' }

  describe '.is_integer?' do
    it 'returns true' do
      expect(string.is_integer?).to be(true)
    end

    context 'the string body is a non integer value' do
      let(:string) { 'a10' }
      it 'returns false' do
        expect(string.is_integer?).to be(false)
      end
    end
  end
end
