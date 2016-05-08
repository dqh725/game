require_relative "constants"

# Execution module defined [place, move, left, right, report] mothod which 
# can be extended into command object to do the operation with robot
# this module is open for expanding new command ...
module Execution
  
  # move command
  def move
    case
    when @robot.face == "north" && @robot.y < @ymax
      @robot.forward_y 1
    when @robot.face == "south" && @robot.y > 0
      @robot.backward_y 1
    when @robot.face == "west" && @robot.x > 0
      @robot.backward_x 1
    when @robot.face == "east" && @robot.x < @xmax
      @robot.forward_x 1
    else
    end
  end

  # rotate 90 degree to left
  def left
    @robot.left
  end

  # rotate 90 degree to right
  def right
    @robot.right
  end

  # report robot status
  def report
    @robot.report
  end
  def place(*args)
    if check_place_params *args
      @robot.place(args[0].to_i, args[1].to_i, args[2])
    end
  end

  private
    # check place atguments, return true if is legal
    def check_place_params *args
      if args.length != 3
        throw_error "wrong number of arguments for place: (#{args.length} for 3)"
        return false
      end
      # params number is 3 ...
      x = args[0].to_i if is_integer args[0]
      y = args[1].to_i if is_integer args[1]
      face = args[2]
      faces = Constants::FACES

      case
      when !is_integer(args[0])
        throw_error "x should be an integer"
      when !is_integer(args[1])
        throw_error "y should be and integer"
      when face.class != String
        throw_error "face should be string type"
      when x > @xmax || x < 0
        throw_error "x exceed the limitation"
      when y > @ymax || y < 0
        throw_error "y exceed the limitation"
      when faces.index(face.downcase).nil?
        throw_error "face value should be one of the #{faces}"
      else
        return true
      end 
    end

    def throw_error err
      begin
        raise err
      rescue
        #customise how to handle wrong type error
        puts "=> "+err
      end
    end

    # check is num or string_num, eg. 1 or '1' return true
    def is_integer str
      return str.class == Fixnum || str == str.to_i.to_s
    end
end

# an example to expand the command type
module Option
  def option
    puts """\
================================ instruction ===================================
            - a toy robot game, with default 5x5 board
            - Command options(case insensitive):

            PLACE X,Y, FACING : PLACE will put the toy robot on the table in \
position X,Y and facing NORTH, SOUTH, EAST or WEST. The origin (0,0) can be \
considered to be the SOUTH WEST most corner. The first valid command to the \
robot is a PLACE command, after that, any sequence of commands may be issued, \
in any order, including another PLACE command. The application should discard \
all commands in the sequence until a valid PLACE command has been executed.


            MOVE: will move the toy robot one unit forward in the direction \
it is currently facing.

            LEFT/RIGHT: will rotate the robot 90 degrees in the specified \
direction without changing the position of the robot.

            REPORT: will announce the X,Y and FACING of the robot.

            Option: help instruction of the game.

            Exit: quit the game.

            - Example
            PLACE 0,0,NORTH
            MOVE
            REPORT
            => Output: 0,1,NORTH
=============================== end of instruction =============================
=> Enter commands: (type \"exit\" to quit; \"option\" for help)"""
  end
end

# Command class: operate robot with legal command
# all the execution methods should be defined in Execution module or 
# included in the command class
class Command
  include Execution
  include Option

  def initialize robot
    @xmax = Constants::MAX_X
    @ymax = Constants::MAX_Y
    @robot = robot
  end

  def take(robot)
    @robot = robot
    return self
  end

end