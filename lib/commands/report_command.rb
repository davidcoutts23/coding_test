# frozen_string_literal: true

require './lib/tabletop'
require_relative 'command'

class ReportCommand < Command
  def perform
    @result = robot.report
  end
end
