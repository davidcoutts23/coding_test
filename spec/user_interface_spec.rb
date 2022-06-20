require 'spec_helper'

RSpec.describe UserInterface do
  subject(:user_interface) { UserInterface.new }

  let(:simulation_orchestrator) { instance_double(SimulationOrchestrator) }
  let(:input) { "PLACE 1,2,NORTH" }

  before(:each) do
    allow(SimulationOrchestrator).to receive(:new).and_return(simulation_orchestrator)
    allow(simulation_orchestrator).to receive(:command_for).with(input)
  end

  it 'sends a perform message to the simulation orchestrator with the input' do
    expect(simulation_orchestrator).to receive(:command_for).with(input)
    simulation_orchestrator.command_for(input)
  end
end
