# frozen_string_literal: true

require './lib/helpers/validate_integer'
require './lib/commands/place_command_arguments'

class PlaceCommandInputProcessor
  class InputValidationError < StandardError; end

  def perform(input)
    slice_input(input)
    validate_argument_length
    extract_arguments
    process_coordinates
    PlaceCommandArguments.new(
      x_coordinate:,
      y_coordinate:,
      cardinal_direction:
    )
  end

  private

  attr_accessor :x_coordinate, :y_coordinate, :cardinal_direction, :input_array

  def slice_input(input)
    @input_array = input.split(/[ ,]+/)
  end

  def validate_argument_length
    return unless input_array.length != 4

    raise InputValidationError,
          'Error: Incorrect number of arguments for PLACE command. Expected format is PLACE X,Y,F'
  end

  def extract_arguments
    @x_coordinate = input_array[1]
    @y_coordinate = input_array[2]
    @cardinal_direction = input_array[3]
  end

  def process_coordinates
    if x_coordinate.integer? && y_coordinate.integer?
      self.x_coordinate = x_coordinate.to_i
      self.y_coordinate = y_coordinate.to_i
    else
      raise InputValidationError, 'Error: X and Y coordinates must be integers. Expected format is PLACE INT,INT,STRING'
    end
  end
end
