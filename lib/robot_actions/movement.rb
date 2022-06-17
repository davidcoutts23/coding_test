# frozen_string_literal: true

require 'position'

class Movement
  def move(position:, orientation:)
    case orientation.cardinal_direction
    when 'NORTH'
      Position.new(
        x_coordinate: position.x_coordinate,
        y_coordinate: position.y_coordinate + 1
      )
    when 'SOUTH'
      Position.new(
        x_coordinate: position.x_coordinate,
        y_coordinate: position.y_coordinate - 1
      )
    when 'EAST'
      Position.new(
        x_coordinate: position.x_coordinate + 1,
        y_coordinate: position.y_coordinate
      )
    when 'WEST'
      Position.new(
        x_coordinate: position.x_coordinate - 1,
        y_coordinate: position.y_coordinate
      )
    end
  end
end
