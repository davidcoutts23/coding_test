# frozen_string_literal: true

require './lib/robot_actions/movement'
require './lib/robot_actions/rotation'

class Robot
  def initialize(position:, orientation:)
    @position = position
    @orientation = orientation
    @movement = Movement.new
    @rotation = Rotation.new
  end

  attr_accessor :position

  def calculate_move
    movement.move(position:, orientation:)
  end

  def execute_rotation(direction)
    rotation.rotate(direction:, orientation:)
  end

  def report
    "Output: #{position.x_coordinate},#{position.y_coordinate},#{orientation.cardinal_direction}"
  end

  private

  attr_reader :movement, :orientation, :rotation
end
