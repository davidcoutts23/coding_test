# frozen_string_literal: true

require './lib/factories/position_factory'

class Movement
  def move(position:, orientation:)
    case orientation.cardinal_direction
    when 'NORTH'
      PositionFactory.generate(
        x_coordinate: position.x_coordinate, y_coordinate: position.y_coordinate + 1
      )
    when 'SOUTH'
      PositionFactory.generate(
        x_coordinate: position.x_coordinate, y_coordinate: position.y_coordinate - 1
      )
    when 'EAST'
      PositionFactory.generate(
        x_coordinate: position.x_coordinate + 1, y_coordinate: position.y_coordinate
      )
    when 'WEST'
      PositionFactory.generate(
        x_coordinate: position.x_coordinate - 1, y_coordinate: position.y_coordinate
      )
    end
  end
end
