# frozen_string_literal: true

class Command
  def initialize(tabletop:, robot:)
    @tabletop = tabletop
    @robot = robot
  end

  attr_reader :result, :robot
end
