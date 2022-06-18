# frozen_string_literal: true

require './lib/commands/place_command'
require './lib/commands/move_command'
require './lib/commands/rotate_command'
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
      move = MoveCommand.new(tabletop:tabletop, robot:robot)
      move.perform
      puts move.result
    when /LEFT/ || /RIGHT/
      rotate = RotateCommand.new(tabletop:tabletop, robot:robot)
      rotate.perform(input)
      puts rotate.result
    end
  end

  private

  attr_accessor :tabletop, :robot
end
