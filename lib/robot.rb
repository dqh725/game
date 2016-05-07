require_relative "variable"

class Robot
	#attr_accessor method
	attr_reader :x, :y, :face

	@@faces = ["north","west","south","east"]

	def initialize
		@max_x = Variable.MAX_X
		@max_y = Variable.MAX_Y
	end

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
			current_index = @@faces.index(@face)
			@face = @@faces[(current_index+3)%4]
		end
	end

	# turn left 90 degree
	def left
		if @face # robot is placed in board
			current_index = @@faces.index(@face)
			@face = @@faces[(current_index+1)%4]
		end
	end

end