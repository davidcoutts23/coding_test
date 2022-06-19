# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rotation do
  subject(:rotation) { Rotation.new }

  let(:direction) { 'LEFT' }
  let(:orientation) { instance_double(Orientation) }

  before(:each) do
    allow(orientation).to receive(:rotate).with(direction)
  end

  it 'sends a rotate message to orientation with the specified direction' do
    expect(orientation).to receive(:rotate).with(direction)
    rotation.rotate(orientation:, direction:)
  end
end
