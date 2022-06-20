# frozen_string_literal: true

require './lib/tabletop'

class TabletopPositionValidator
  def self.validate(position:, tabletop:)
    tabletop.validate_position(position)
  end
end
