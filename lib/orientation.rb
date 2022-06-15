# frozen_string_literal: true

class Orientation
  class NonExistentCardinalDirectionError < StandardError; end

  def initialize(cardinal_direction)
    @cardinal_direction = cardinal_direction
  end

  def self.validate_cardinal_direction(cardinal_direction)
    return if cardinal_directions.include?(cardinal_direction)

    raise NonExistentCardinalDirectionError,
          'Error: Cardinal direction does not exist.'
  end

  attr_reader :cardinal_direction

  def self.cardinal_directions
    %w[NORTH SOUTH EAST WEST]
  end
end
