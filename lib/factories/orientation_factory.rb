# frozen_string_literal: true

require './lib/orientation'

class OrientationFactory
  def self.generate(cardinal_direction:)
    Orientation.new(cardinal_direction:)
  end
end
