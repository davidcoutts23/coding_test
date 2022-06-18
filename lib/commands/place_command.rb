# frozen_string_literal: true

require './lib/robot'
require './lib/position'
require './lib/orientation'
require './lib/commands/place_command_input_processor'

class PlaceCommand
  class PlaceCommandInvalidError < StandardError; end

  def initialize(tabletop)
    @tabletop = tabletop
  end

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

  attr_reader :robot, :result

  private

  attr_reader :tabletop, :place_command_arguments

  def process_input_for(input)
    @place_command_arguments = PlaceCommandInputProcessor.new.perform(input)
  end

  def validate_cardinal_direction
    Orientation.validate_cardinal_direction(place_command_arguments.cardinal_direction)
  end

  def validate_position
    tabletop.validate_position(Position.new(
                                 x_coordinate: place_command_arguments.x_coordinate,
                                 y_coordinate: place_command_arguments.y_coordinate
                               ))
  end

  def place_robot
    @result = 'Robot placed'
    Robot.new(
      position: Position.new(x_coordinate: place_command_arguments.x_coordinate,
                             y_coordinate: place_command_arguments.y_coordinate),
      orientation: Orientation.new(cardinal_direction: place_command_arguments.cardinal_direction)
    )
  end
end
