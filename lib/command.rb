require_relative "variable"

# command factory pattern
class Command

	def initialize
		@xmax = Variable.MAX_X
		@ymax = Variable.MAX_Y
		#@move_step = Variable.MOVE_STEP
	end

  def take(robot)
  	@robot = robot
  	return self
  end

  # this method will be extended into command object with certail module
  # E.G. command.extend(Move).execute
  # def execute
  # end

end

module Place
  def execute(*args)
    @robot.place(*args) if check_place_params *args
  end

  private
    # check place command ... return true if is legal
    def check_place_params *args
      if args.length != 3 
        wrong_params_number "wrong number of arguments (#{args.length} for 3)"
        return false
      end
      # params number is 3 ...
      x = args[0]
      y = args[1]
      face = args[2]
      faces = Variable.FACES
      case
      when x.class != Fixnum
        wrong_type "x should be an integer"
      when y.class != Fixnum
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
      raise err
    end

    def wrong_params_number err
      raise err
    end

    def illegal_value err
      raise err
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