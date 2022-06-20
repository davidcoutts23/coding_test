# Robot challenge

My solution to the robot challenge coding test

## Requirements

Create an application that can read in commands of the following form:

```plain
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X,Y and orientation of the robot.
- A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.

## Dependencies

* Docker

## Usage

- Clone repository `git clone https://github.com/davidcoutts23/coding_test.git`
- cd into project directory `cd coding_test`
- Build docker image `docker build -t robot_challenge .`

### Running the app

`docker run -it robot_challenge bundle exec rake run`

### Running the test suite 

`docker run -it robot_challenge bundle exec rake test` to run unit tests
`docker run -it robot_challenge bundle exec rake integration_test` to run integration tests only



