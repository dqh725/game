require_relative "variable"

# command factory pattern
class Command

	def initialize
		@xmax = Variable.MAX_X
		@ymax = Variable.MAX_Y
		#@move_step = Variable.MOVE_STEP
	end

  def take(robot, *args)
  	@robot = robot
  	@args = *args
  	return self
  end

end

module Place
  def execute
    "place command#{@args}"
  end
end

# move command
module Move
  def execute
  	case
		when @robot.face == "north" && @robot.y < @ymax
			@robot.increment_y
		when @robot.face == "south" && @robot.y > 0
			@robot.decrement_y
		when @robot.face == "west" && @robot.x > 0
			@robot.decrement_x
		when @robot.face == "east" && @robot.x < @xmax
			@robot.increment_x
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