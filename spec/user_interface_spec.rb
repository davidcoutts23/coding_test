# frozen_string_literal: true

require_relative '../lib/squarer'
require 'rspec'

describe Squarer do
  it 'square a number' do
    squarer = Squarer.new
    expect(squarer.square(2)).to eq(4)
  end
end
