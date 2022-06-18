# frozen_string_literal: true

require './lib/tabletop'

class MoveCommand
  def initialize(tabletop:, robot:)
    @tabletop = tabletop
    @robot = robot
  end

  attr_reader :result

  def perform
    @new_position = robot.calculate_move
    begin
      tabletop.validate_position(new_position)
      robot.set_position(new_position)
      @result = "Robot moved to #{new_position.x_coordinate}, #{new_position.y_coordinate}."
    rescue StandardError => e
      Tabletop::NonExistentTabletopPositionError
      @result = e.message
    end
  end

  private

  attr_reader :robot, :tabletop, :new_position
end
