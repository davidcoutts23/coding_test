# frozen_string_literal: true

require_relative 'command'

class RotateCommand < Command
  def perform(direction)
    robot.execute_rotation(direction)
    @result = "Robot has been rotated #{direction}"
  end

  private

  attr_reader :tabletop
end
