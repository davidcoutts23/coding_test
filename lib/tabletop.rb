# frozen_string_literal: true

class Tabletop
  def initialize(x_units:, y_units:)
    @x_units = x_units
    @y_units = y_units
  end

  def position_valid?(position)
    if position.x_coordinate < x_units && position.y_coordinate < y_units
      true
    else
      false
    end
  end

  private

  attr_reader :x_units, :y_units
end
