# frozen_string_literal: true

class SimulationOrchestrator
  def initialize
    @robot = nil
    @tabletop = nil
  end

  def command_for(input)
    case input
    when /PLACE/
      puts 'place command created'
    end
  end
end
