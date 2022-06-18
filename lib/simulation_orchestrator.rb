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
      place = PlaceCommand.new(tabletop)
      @robot = place.perform(input)
      @result = place.result
    when /MOVE/
      move = MoveCommand.new(tabletop:tabletop, robot:robot)
      move.perform
      @result = move.result
    when /LEFT/, /RIGHT/
      rotate = RotateCommand.new(tabletop:tabletop, robot:robot)
      rotate.perform(input)
      @result = rotate.result
    end
  end

  attr_reader :result

  private

  attr_accessor :tabletop, :robot
end
