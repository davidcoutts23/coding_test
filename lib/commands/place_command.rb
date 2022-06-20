# frozen_string_literal: true

require './lib/factories/robot_factory'
require './lib/factories/position_factory'
require './lib/factories/orientation_factory'
require_relative 'place_command_input_processor'
require_relative 'command'
require './lib/validators/tabletop_position_validator'
require './lib/validators/cardinal_direction_validator'

class PlaceCommand < Command
  class PlaceCommandInvalidError < StandardError; end

  def perform(input)
    process_input_for(input)
    validate_cardinal_direction
    validate_position
    place_robot
  rescue StandardError => e
    PlaceCommandInputProcessor::InputValidationError
    Orientation::NonExistentCardinalDirectionError
    Tabletop::NonExistentTabletopPositionError
    @result = e.message
  end

  private

  attr_reader :tabletop, :place_command_arguments

  def process_input_for(input)
    @place_command_arguments = PlaceCommandInputProcessor.new.perform(input)
  end

  def validate_cardinal_direction
    CardinalDirectionValidator.validate(place_command_arguments.cardinal_direction)
  end

  def validate_position
    TabletopPositionValidator.validate(position: PositionFactory.generate(
      x_coordinate: place_command_arguments.x_coordinate,
      y_coordinate: place_command_arguments.y_coordinate
    ), tabletop:)
  end

  def place_robot
    @result = 'Robot placed'
    RobotFactory.generate(
      position: PositionFactory.generate(x_coordinate: place_command_arguments.x_coordinate,
                                         y_coordinate: place_command_arguments.y_coordinate),
      orientation: OrientationFactory.generate(cardinal_direction: place_command_arguments.cardinal_direction)
    )
  end
end
