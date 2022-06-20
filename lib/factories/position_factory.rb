# frozen_string_literal: true

require './lib/position'

class PositionFactory
  def self.generate(x_coordinate:, y_coordinate:)
    Position.new(x_coordinate:, y_coordinate:)
  end
end
