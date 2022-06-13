# frozen_string_literal: true

require 'spec_helper'
require 'rspec'
require 'tabletop'
require 'position'

RSpec.describe Tabletop do
  subject(:tabletop) { Tabletop.new(x_units: 5, y_units: 5) }

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
    it 'returns true for a valid position on the tabletop' do
      expect(tabletop.position_valid?(position)).to be(true)
    end

    context 'an x coordinate provided is out of range' do
      let(:x_coordinate) { 5 }
      it 'returns false for an ivalid position on the tabletop' do
        expect(tabletop.position_valid?(position)).to be(false)
      end
    end

    context 'a y coordinate provided is out of range' do
      let(:y_coordinate) { 5 }
      it 'returns false for an ivalid position on the tabletop' do
        expect(tabletop.position_valid?(position)).to be(false)
      end
    end

    context 'both x and y coordinates provided are out of range' do
      let(:x_coordinate) { 5 }
      let(:y_coordinate) { 5 }
      it 'returns false for an ivalid position on the tabletop' do
        expect(tabletop.position_valid?(position)).to be(false)
      end
    end
  end
end
