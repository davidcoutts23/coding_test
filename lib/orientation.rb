# frozen_string_literal: true

class Orientation
  def initialize(cardinal_direction)
    @cardinal_direction = cardinal_direction
  end

  def self.exist?(cardinal_direction)
    cardinal_directions.include?(cardinal_direction)
  end

  attr_reader :cardinal_direction

  def self.cardinal_directions
    %w[NORTH SOUTH EAST WEST]
  end
end
