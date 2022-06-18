# frozen_string_literal: true

require './lib/robot_actions/movement'

class Robot
  def initialize(position:, orientation:)
    @position = position
    @orientation = orientation
    @movement = Movement.new
    @rotation = Rotation.new
  end

  def calculate_move
    movement.move(position:, orientation:)
  end

  # TODO:  Should be using attr writer for this but was having problems with the spec.
  def set_position(position)
    @position = position
  end

  def calculate_rotation(direction)
    @orientation = rotation.rotate(direction: direction, orientation: orientation)
  end 

  def execute_rotation(orientation)
    @orientation = orientation
  end

  private

  attr_reader :movement, :orientation, :position
end
