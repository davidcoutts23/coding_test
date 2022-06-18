# frozen_string_literal: true

require './lib/robot_actions/movement'

class Robot
  def initialize(position:, orientation:)
    @position = position
    @orientation = orientation
    @movement = Movement.new
  end

  def calculate_move
    movement.move(position:, orientation:)
  end

  # TODO:  Should be using attr writer for this but was having problems with the spec.
  def set_position(position)
    @position = position
  end

  private

  attr_reader :movement, :orientation, :position
end
