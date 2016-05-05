require_relative "variable"

class Robot
	#attr_accessor method
	attr_reader :x, :y, :face

	@@face = ["north", "south", "west", "east"]

	def place x, y, face
		if check_params x, y, face
			@x = x
			@y = y
			@face = face.downcase
		end
	end

	def check_params x, y, face
		max_x = Variable.MAX_X
		max_y = Variable.MAX_Y
		case
		when x.class!=Fixnum
			wrong_type "x should be integer in [0, #{max_x}]"
		when y.class!=Fixnum
			wrong_type "y should be integer in [0, #{max_y}]"
		when face.class!=String
			wrong_type "face should be string type"
		when x > max_x || x < 0
			illegal_value "x exceed the limitation"
		when y > max_y || y < 0
			illegal_value "y exceed the limitation"
		when @@face.index(face.downcase).nil?
			illegal_value "face value should be one of the #{@@face}"
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