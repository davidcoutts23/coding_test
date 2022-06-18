# frozen_string_literal: true

require './lib/commands/place_command'
require './lib/commands/move_command'
require './lib/tabletop'

class SimulationOrchestrator
  def initialize
    @robot = nil
    @tabletop = Tabletop.new(x_units: 5, y_units: 5)
  end

  def command_for(input)
    case input
    when /PLACE/
      @robot = PlaceCommand.new(tabletop).perform(input)
    when /MOVE/
      move = MoveCommand.new(tabletop:, robot:)
      move.perform
      puts move.response
    end
  end

  private

  attr_accessor :tabletop, :robot
end
