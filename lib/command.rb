require_relative "constants"

# command factory pattern
class Command

	def initialize robot
		@xmax = Constants::MAX_X
		@ymax = Constants::MAX_Y
    @robot = robot
	end

  def take(robot)
  	@robot = robot
  	return self
  end

  # executed method is not defined yet
  # It method will be extended into command object with certain module
  # E.G. command.extend(Move).execute

end

module Place
  def execute(*args)
    if check_place_params *args
      @robot.place(args[0].to_i, args[1].to_i, args[2])
    end
  end

  private
    # check place command ... return true if is legal
    def check_place_params *args
      if args.length != 3
        wrong_params_number "wrong number of arguments (#{args.length} for 3)"
        return false
      end
      # params number is 3 ...
      x = args[0].to_i if is_integer args[0]
      y = args[1].to_i if is_integer args[1]
      face = args[2]
      faces = Constants::FACES
      case
      when !is_integer(args[0])
        wrong_type "x should be an integer"
      when !is_integer(args[1])
        wrong_type "y should be and integer"
      when face.class != String
        wrong_type "face should be string type"
      when x > @xmax || x < 0
        illegal_value "x exceed the limitation"
      when y > @ymax || y < 0
        illegal_value "y exceed the limitation"
      when faces.index(face.downcase).nil?
        illegal_value "face value should be one of the #{faces}"
      else
        return true
      end 
    end

    def wrong_type err
      begin
        raise err
      rescue
        #customise how to handle the error
        puts err
      end
    end

    def wrong_params_number err
      begin
        raise err
      rescue
        #customise how to handle the error
        puts err
      end
    end

    def illegal_value err
      begin
        raise err
      rescue
        #customise how to handle the error
        puts err
      end
    end

    # check is num or string_num, eg. 1 or '1' return true
    def is_integer str
      return str.class == Fixnum || str == str.to_i.to_s
    end
end

# move command
module Move
  def execute
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
end

module Left
  def execute
    @robot.left
  end
end

module Right
  def execute
    @robot.right
  end
end

module Report
  def execute
    @robot.report
  end
end