# frozen_string_literal: true

require './lib/tabletop'
require_relative 'command'
require './lib/validators/tabletop_position_validator'

class MoveCommand < Command
  def perform
    @new_position = robot.calculate_move
    begin
      TabletopPositionValidator.validate(position: new_position, tabletop: tabletop)
      robot.position = new_position
      @result = "Robot moved to #{new_position.x_coordinate}, #{new_position.y_coordinate}"
    rescue StandardError => e
      Tabletop::NonExistentTabletopPositionError
      @result = e.message
    end
  end

  private

  attr_reader :tabletop, :new_position
end
