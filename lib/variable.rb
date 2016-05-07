class Variable
	class << self
		attr_accessor :MAX_X, :MAX_Y, :MOVE_STEP, :FACES
	end

  @MAX_X = 4
  @MAX_Y = 4
  @FACES = ["north","west","south","east"]
  @MOVE_STEP = 1

end

