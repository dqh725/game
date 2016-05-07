require_relative "constants"

class Robot
	#attr_accessor method
	attr_reader :x, :y, :face

	# command object should take care of the params check
	def place x, y, face
		@x = x
		@y = y
		@face = face.downcase
	end

	# move forward one unit towards the current face
	def forward_x(step); @x += step end
	def forward_y(step); @y += step end
	def backward_x(step); @x -= step end
	def backward_y(step); @y -= step end

	# turn right 90 degree
	def right
		if @face # robot is placed in board
			current_index = Constants::FACES.index(@face)
			@face = Constants::RIGHT_FACES[current_index]
		end
	end

	# turn left 90 degree
	def left
		if @face # robot is placed in board
			current_index = Constants::FACES.index(@face)
			@face = Constants::LEFT_FACES[current_index]
		end
	end

	# report current position and face 
	def report
		
	end

end