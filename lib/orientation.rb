# frozen_string_literal: true

class Orientation
  class NonExistentCardinalDirectionError < StandardError; end

  def initialize(cardinal_direction:)
    @cardinal_direction = cardinal_direction
  end

  def rotate(direction)
    Orientation.cardinal_directions.each_with_index.map do |element, index|
      next unless element == cardinal_direction

      @cardinal_direction = Orientation.retreive_cardinal_direction_for(index +
        (direction == 'left' ? -1 : 1))
      break
    end
  end

  def self.validate_cardinal_direction(cardinal_direction)
    return if cardinal_directions.include?(cardinal_direction)

    raise NonExistentCardinalDirectionError,
          'Error: Cardinal direction does not exist.'
  end

  def self.retreive_cardinal_direction_for(index)
    cardinal_directions[index % cardinal_directions.length]
  end

  attr_reader :cardinal_direction

  def self.cardinal_directions
    %w[NORTH EAST SOUTH WEST]
  end
end
