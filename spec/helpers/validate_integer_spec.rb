# frozen_string_literal: true

require 'spec_helper'

RSpec.describe String do
  subject(:string) { '10' }

  describe '.integer?' do
    it 'returns true' do
      expect(string.integer?).to be(true)
    end

    context 'the string body is a non integer value' do
      let(:string) { 'a10' }
      it 'returns false' do
        expect(string.integer?).to be(false)
      end
    end
  end
end
