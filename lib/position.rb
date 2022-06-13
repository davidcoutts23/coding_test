# frozen_string_literal: true

class Position
  def initialize(x_coordinate:, y_coordinate:)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
  end

  attr_reader :x_coordinate, :y_coordinate
end
