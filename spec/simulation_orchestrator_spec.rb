# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Robot do
  subject(:simulation_orchestrator) { SimulationOrchestrator.new }

  let(:tabletop) { instance_double(Tabletop) }
  let(:robot) { instance_double(Robot) }
  let(:place_command) { instance_double(PlaceCommand) }
  let(:move_command) { instance_double(MoveCommand) }
  let(:rotate_command) { instance_double(RotateCommand) }
  let(:report_command) { instance_double(ReportCommand) }
  let(:result) { 'Result' }

  before(:each) do
    allow(Tabletop).to receive(:new).with(x_units: 5, y_units: 5).and_return(tabletop)

    allow(PlaceCommand).to receive(:new).and_return(place_command)
    allow(place_command).to receive(:perform).with('PLACE').and_return(robot)
    allow(place_command).to receive(:result).and_return(result)

    allow(MoveCommand).to receive(:new).and_return(move_command)
    allow(move_command).to receive(:perform)
    allow(move_command).to receive(:result).and_return(result)

    allow(RotateCommand).to receive(:new).and_return(rotate_command)
    allow(rotate_command).to receive(:perform)
    allow(rotate_command).to receive(:result).and_return(result)

    allow(ReportCommand).to receive(:new).and_return(report_command)
    allow(report_command).to receive(:perform)
    allow(report_command).to receive(:result).and_return(result)
  end

  describe '.command_for' do
    context 'PLACE command is issued' do
      let(:input) { 'PLACE' }
      it 'Initializes a place command when input is place' do
        expect(PlaceCommand).to receive(:new).and_return(place_command)
        simulation_orchestrator.command_for(input)
      end

      it 'saves the placed robot' do
        expect(place_command).to receive(:perform).with(input).and_return(robot)
        simulation_orchestrator.command_for(input)
      end

      it 'saves the result' do
        simulation_orchestrator.command_for(input)
        expect(simulation_orchestrator.result).to eq(result)
      end
    end

    context 'MOVE command is issued' do
      let(:input) { 'MOVE' }
      context 'before robot is placed' do
        it 'has a result value indicating command is ignored' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq('No robot placed, command ignored')
        end
      end

      context 'after robot is placed' do
        before do
          simulation_orchestrator.command_for('PLACE')
        end
        it 'Initializes a move command when input is move' do
          expect(MoveCommand).to receive(:new).and_return(move_command)
          simulation_orchestrator.command_for(input)
        end

        it 'moves the robot' do
          expect(move_command).to receive(:perform)
          simulation_orchestrator.command_for(input)
        end

        it 'saves the result' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq(result)
        end
      end
    end

    context 'LEFT command is issued' do
      let(:input) { 'LEFT' }
      context 'before robot is placed' do
        it 'has a result value indicating command is ignored' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq('No robot placed, command ignored')
        end
      end

      context 'after robot is placed' do
        before do
          simulation_orchestrator.command_for('PLACE')
        end
        it 'Initializes a rotate command when input is left' do
          expect(RotateCommand).to receive(:new).and_return(rotate_command)
          simulation_orchestrator.command_for(input)
        end

        it 'rotates the robot' do
          expect(rotate_command).to receive(:perform)
          simulation_orchestrator.command_for(input)
        end

        it 'saves the result' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq(result)
        end
      end
    end

    context 'RIGHT command is issued' do
      let(:input) { 'RIGHT' }
      context 'before robot is placed' do
        it 'has a result value indicating command is ignored' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq('No robot placed, command ignored')
        end
      end

      context 'after robot is placed' do
        before do
          simulation_orchestrator.command_for('PLACE')
        end
        it 'Initializes a rotate command when input is right' do
          expect(RotateCommand).to receive(:new).and_return(rotate_command)
          simulation_orchestrator.command_for(input)
        end

        it 'rotates the robot' do
          expect(rotate_command).to receive(:perform)
          simulation_orchestrator.command_for(input)
        end

        it 'saves the result' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq(result)
        end
      end
    end

    context 'REPORT command is issued' do
      let(:input) { 'REPORT' }
      context 'before robot is placed' do
        it 'has a result value indicating command is ignored' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq('No robot placed, command ignored')
        end
      end

      context 'after robot is placed' do
        before do
          simulation_orchestrator.command_for('PLACE')
        end
        it 'Initializes a rotate command when input is report' do
          expect(ReportCommand).to receive(:new).and_return(report_command)
          simulation_orchestrator.command_for(input)
        end

        it 'reports robots location' do
          expect(report_command).to receive(:perform)
          simulation_orchestrator.command_for(input)
        end

        it 'saves the result' do
          simulation_orchestrator.command_for(input)
          expect(simulation_orchestrator.result).to eq(result)
        end
      end
    end
  end
end
