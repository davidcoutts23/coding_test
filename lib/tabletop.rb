# frozen_string_literal: true

class Tabletop
  class NonExistentTabletopPositionError < StandardError; end

  def initialize(x_units:, y_units:)
    @x_units = x_units
    @y_units = y_units
  end

  def validate_position(position)
    return if (0..x_units - 1).include?(position.x_coordinate) && (0..y_units - 1).include?(position.y_coordinate)

    raise NonExistentTabletopPositionError,
          'Error: Position does not exist on the tabletop.'
  end

  private

  attr_reader :x_units, :y_units
end
