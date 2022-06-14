# frozen_string_literal: true

class PlaceCommandArguments
  def initialize(x_coordinate:, y_coordinate:, cardinal_direction:)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @cardinal_direction = cardinal_direction
  end

  attr_reader :x_coordinate, :y_coordinate, :cardinal_direction
end
