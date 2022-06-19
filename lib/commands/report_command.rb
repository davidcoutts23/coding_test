# frozen_string_literal: true

require './lib/tabletop'

class ReportCommand
  def initialize(tabletop:, robot:)
    @tabletop = tabletop
    @robot = robot
  end

  attr_reader :result

  def perform
    @result = robot.report
  end

  private

  attr_reader :robot
end
