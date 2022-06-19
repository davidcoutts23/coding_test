# frozen_string_literal: true

require './lib/commands/place_command'
require './lib/commands/move_command'
require './lib/commands/rotate_command'
require './lib/commands/report_command'
require './lib/tabletop'
require 'limiter'

class SimulationOrchestrator
  extend Limiter::Mixin
  limit_method(:command_for, rate: 1000) do
    # Simply puts-ing a message and exiting the app is not exactly graceful. 
    # Couldn't figure out how to return a value for command_for to re-enter the loop
    puts 'Command limit (1000/minute) exceeded. Goodbye.'
    exit
  end

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
      return unless robot_placed?

      move = MoveCommand.new(tabletop:, robot:)
      move.perform
      @result = move.result
    when /LEFT/, /RIGHT/
      return unless robot_placed?

      rotate = RotateCommand.new(tabletop:, robot:)
      rotate.perform(input)
      @result = rotate.result
    when /REPORT/
      return unless robot_placed?

      report = ReportCommand.new(tabletop:, robot:)
      report.perform
      @result = report.result
  end

  attr_reader :result

  private

  attr_accessor :tabletop, :robot

  def robot_placed?
    return true unless @robot.nil?

    @result = 'No robot placed, command ignored'
    false
  end
end
