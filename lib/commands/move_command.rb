# frozen_string_literal: true

require './lib/tabletop'

class MoveCommand
  def initialize(tabletop:, robot:)
    @tabletop = tabletop
    @robot = robot
  end

  attr_reader :response

  def perform
    @new_position = robot.calculate_move
    begin
      tabletop.validate_position(new_position)
      robot.set_position(new_position)
      @response = "Robot moved to #{new_position.x_coordinate}, #{new_position.y_coordinate}."
    rescue StandardError => e
      Tabletop::NonExistentTabletopPositionError
      @response = e.message
    end
  end

  private

  attr_reader :robot, :tabletop, :new_position
end
