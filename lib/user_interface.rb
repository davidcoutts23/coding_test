# frozen_string_literal: true

require_relative 'simulation_orchestrator'

module UserInterface
  def self.main
    simulation_orchestrator = SimulationOrchestrator.new

    loop do
      print 'Input command: '
      input = gets
      simulation_orchestrator.command_for(input)
    end
  end
end
