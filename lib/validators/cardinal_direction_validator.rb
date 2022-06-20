# frozen_string_literal: true
require './lib/orientation'

class CardinalDirectionValidator
  def self.validate(cardinal_direction)
    Orientation.validate_cardinal_direction(cardinal_direction)
  end
end

