require_relative "variable"

class Robot
	#attr_accessor method
	attr_reader :x, :y, :face

	@@faces = ["north","west","south","east"]

	def initialize
		@max_x = Variable.MAX_X
		@max_y = Variable.MAX_Y
	end

	def place x, y, face
		if check_params x, y, face
			@x = x
			@y = y
			@face = face.downcase
		end
	end

	# move forward one unit towards the current face
	def increment_x; @x+=1 end
	def increment_y; @y+=1 end
	def decrement_x; @x-=1 end
	def decrement_y; @y-=1 end

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
			current_index =@@faces.index(@face)
			@face = @@faces[(current_index+1)%4]
		end
	end


	def check_params x, y, face
		case
		when x.class != Fixnum
			wrong_type "x should be integer in [0, #{@max_x}]"
		when y.class != Fixnum
			wrong_type "y should be integer in [0, #{@max_y}]"
		when face.class != String
			wrong_type "face should be string type"
		when x > @max_x || x < 0
			illegal_value "x exceed the limitation"
		when y > @max_y || y < 0
			illegal_value "y exceed the limitation"
		when @@faces.index(face.downcase).nil?
			illegal_value "face value should be one of the #{@@faces}"
		else
			return true
		end 
	end

	def wrong_type err
		raise err
	end

	def illegal_value err
		raise err
	end
end