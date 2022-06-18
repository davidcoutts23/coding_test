# frozen_string_literal: true

class RotateCommand
  def initialize(tabletop:, robot:)
    @tabletop = tabletop
    @robot = robot
  end

  attr_reader :result

  def perform(direction)
    robot.execute_rotation(direction)
    @result = "Robot has been rotated #{direction}"
  end

  private

  attr_reader :robot, :tabletop, :new_orientation
end
