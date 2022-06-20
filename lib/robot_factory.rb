# frozen_string_literal: true

require 'robot'

class RobotFactory
  def self.generate(position:, orientation:)
    Robot.new(position:, orientation:)
  end
end
