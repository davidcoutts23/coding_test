# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'integration test' do
  subject(:sim_orc) { SimulationOrchestrator.new }
  it 'returns returns correct result for first example input and output' do
    sim_orc.command_for('PLACE 0,0,NORTH')
    expect(sim_orc.result).to eq('Robot placed')
    sim_orc.command_for('MOVE')
    expect(sim_orc.result).to eq('Robot moved to 0, 1')
    sim_orc.command_for('REPORT')
    expect(sim_orc.result).to eq('Output: 0,1,NORTH')
  end

  it 'returns returns correct result for second example input and output' do
    sim_orc.command_for('PLACE 0,0,NORTH')
    expect(sim_orc.result).to eq('Robot placed')
    sim_orc.command_for('LEFT')
    expect(sim_orc.result).to eq('Robot has been rotated LEFT')
    sim_orc.command_for('REPORT')
    expect(sim_orc.result).to eq('Output: 0,0,WEST')
  end

  it 'returns returns correct result for third example input and output' do
    sim_orc.command_for('PLACE 1,2,EAST')
    expect(sim_orc.result).to eq('Robot placed')
    sim_orc.command_for('MOVE')
    expect(sim_orc.result).to eq('Robot moved to 2, 2')
    sim_orc.command_for('MOVE')
    expect(sim_orc.result).to eq('Robot moved to 3, 2')
    sim_orc.command_for('LEFT')
    expect(sim_orc.result).to eq('Robot has been rotated LEFT')
    sim_orc.command_for('MOVE')
    expect(sim_orc.result).to eq('Robot moved to 3, 3')
    sim_orc.command_for('REPORT')
    expect(sim_orc.result).to eq('Output: 3,3,NORTH')
  end

  context 'attempted placement to a position outside of the tabletop. Successful reattempt.' do
    it 'raises and error, and then successfully allows second place attempt' do
      sim_orc.command_for('PLACE 5,2,EAST')
      expect(sim_orc.result).to eq('Error: Position does not exist on the tabletop.')
      sim_orc.command_for('PLACE 4,2,EAST')
      expect(sim_orc.result).to eq('Robot placed')
    end
  end

  context 'attempted placement to with an invalid cardinal direction. Successful reattempt.' do
    it 'raises and error, and then successfully allows second place attempt' do
      sim_orc.command_for('PLACE 0,0,NORTHEAST')
      expect(sim_orc.result).to eq('Error: Cardinal direction does not exist.')
      sim_orc.command_for('PLACE 0,0,EAST')
      expect(sim_orc.result).to eq('Robot placed')
    end
  end

  context 'attempted placement to with a missing coordinate. Successful reattempt.' do
    it 'raises and error, and then successfully allows second place attempt' do
      sim_orc.command_for('PLACE 0,EAST')
      expect(sim_orc.result).to eq('Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F')
      sim_orc.command_for('PLACE 0,0,EAST')
      expect(sim_orc.result).to eq('Robot placed')
    end
  end

  context 'attempt to move to a position off the tabletop. Perform rotation and successful reattempt.' do
    it 'raises and error, and then successfully allows second place attempt' do
      sim_orc.command_for('PLACE 4,4,NORTH')
      expect(sim_orc.result).to eq('Robot placed')
      sim_orc.command_for('MOVE')
      expect(sim_orc.result).to eq('Error: Position does not exist on the tabletop.')
      sim_orc.command_for('LEFT')
      expect(sim_orc.result).to eq('Robot has been rotated LEFT')
      sim_orc.command_for('MOVE')
      expect(sim_orc.result).to eq('Robot moved to 3, 4')
      sim_orc.command_for('REPORT')
      expect(sim_orc.result).to eq('Output: 3,4,WEST')
    end
  end

  context 'enter a move, left, right command before placement, then allow placement and movement' do
    it 'ignores the commands before placement, then proceeds as normal' do
      sim_orc.command_for('LEFT')
      sim_orc.command_for('RIGHT')
      sim_orc.command_for('MOVE')
      sim_orc.command_for('PLACE 0,0,NORTH')
      expect(sim_orc.result).to eq('Robot placed')
      sim_orc.command_for('MOVE')
      expect(sim_orc.result).to eq('Robot moved to 0, 1')
      sim_orc.command_for('REPORT')
      expect(sim_orc.result).to eq('Output: 0,1,NORTH')
    end
  end

  context 'enter a valid placement, then invalid, and then valid' do
    it 'proceeds as normal following the third placement' do
      sim_orc.command_for('PLACE 0,0,NORTH')
      expect(sim_orc.result).to eq('Robot placed')
      sim_orc.command_for('PLACE 0,NORTH')
      expect(sim_orc.result).to eq('Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F')
      sim_orc.command_for('PLACE 0,0,NORTH')
      expect(sim_orc.result).to eq('Robot placed')
      sim_orc.command_for('MOVE')
      expect(sim_orc.result).to eq('Robot moved to 0, 1')
      sim_orc.command_for('REPORT')
      expect(sim_orc.result).to eq('Output: 0,1,NORTH')
    end
  end

  context 'Automate entry of commands' do
    it 'successfully executes ~900 commands and reports correctly' do
      sim_orc.command_for('PLACE 0,0,NORTH')
      expect(sim_orc.result).to eq('Robot placed')
      900.times { sim_orc.command_for('LEFT') }
      sim_orc.command_for('REPORT')
      expect(sim_orc.result).to eq('Output: 0,0,NORTH')
    end
    it 'unsuccessfully executes ~1100. Exits the app.' do
      sim_orc.command_for('PLACE 0,0,NORTH')
      expect(sim_orc.result).to eq('Robot placed')
      expect { 1100.times { sim_orc.command_for('LEFT') } }.to raise_error(SystemExit)
    end
  end
end
