# frozen_string_literal: true

require './lib/robot_actions/movement'

class Robot
  def initialize(position:, orientation:)
    @position = position
    @orientation = orientation
    @movement = Movement.new
  end

  def move
    movement.move(position, orientation)
  end

  private

  attr_reader :movement, position, orientation
end
