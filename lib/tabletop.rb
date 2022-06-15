# frozen_string_literal: true

class Tabletop
  class NonExistentTabletopPositionError < StandardError; end

  def initialize(x_units:, y_units:)
    @x_units = x_units
    @y_units = y_units
  end

  def validate_position(position)
    return if position.x_coordinate < x_units && position.y_coordinate < y_units

    raise NonExistentTabletopPositionError,
          'Error: Position does not exist on the tabletop.'
  end

  private

  attr_reader :x_units, :y_units
end
