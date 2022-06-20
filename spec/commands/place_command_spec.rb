# frozen_string_literal: true

RSpec.describe PlaceCommand do
  subject(:place_command) { PlaceCommand.new(tabletop:, robot:).perform(input) }

  let(:tabletop) { instance_double(Tabletop) }
  let(:robot) { instance_double(Robot) }

  let(:input) { 'PLACE 10,20,NORTH' }
  let(:x_coordinate) { 1 }
  let(:y_coordinate) { 2 }
  let(:cardinal_direction) { 'NORTH' }

  let(:place_command_arguments) do
    instance_double(
      PlaceCommandArguments,
      x_coordinate:,
      y_coordinate:,
      cardinal_direction:
    )
  end

  let(:position) do
    instance_double(
      Position
    )
  end

  let(:orientation) do
    instance_double(
      Orientation
    )
  end

  let(:place_command_input_processor) { double }

  before(:each) do
    allow(PlaceCommandInputProcessor).to receive(:new).and_return(place_command_input_processor)
    allow(place_command_input_processor).to receive(:perform).with(input).and_return(place_command_arguments)

    allow(CardinalDirectionValidator).to receive(:validate).with(cardinal_direction).and_return(nil)
    allow(TabletopPositionValidator).to receive(:validate).with(position:, tabletop:).and_return(nil)

    allow(PositionFactory).to receive(:generate).with(x_coordinate:, y_coordinate:).and_return(position)
    allow(OrientationFactory).to receive(:generate).with(cardinal_direction:).and_return(orientation)

    allow(RobotFactory).to receive(:generate).with(position:, orientation:)
  end

  describe '.perform' do
    it 'places a robot at the specified position and orientation' do
      expect(RobotFactory).to receive(:generate).with(position:, orientation:)
      place_command
    end

    context 'the input processor raises an exception' do
      before(:each) do
        allow(place_command_input_processor).to receive(:perform) do
          raise PlaceCommandInputProcessor::InputValidationError
        end
      end
      it 'does not place a robot' do
        expect(RobotFactory).not_to receive(:generate).with(orientation:, position:)
        place_command
      end
    end

    context 'cardinal direction validation raises an error' do
      before(:each) do
        allow(CardinalDirectionValidator).to receive(:validate).with(cardinal_direction) do
          raise Orientation::NonExistentCardinalDirectionError
        end
      end
      it 'does not place a robot' do
        expect(RobotFactory).not_to receive(:generate).with(orientation:, position:)
        place_command
      end
    end

    context 'position validation on tabletop raises an error' do
      before(:each) do
        allow(TabletopPositionValidator).to receive(:validate) do
          raise Tabletop::NonExistentTabletopPositionError
        end
      end
      it 'does not place a robot' do
        expect(RobotFactory).not_to receive(:generate).with(orientation:, position:)
        place_command
      end
    end
  end
end
