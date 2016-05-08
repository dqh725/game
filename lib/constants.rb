module Constants
  # this module defined all the project related constants,
  # they can be modified easily
  MAX_X = 4 # width of game board [0-4]
  MAX_Y = 4 # length of game board [0-4]

  # available face options for robot
  # FACES[i] -(turn right)-> RIGHT_FACES[i]
  # FACES[i] -(turn left)-> LEFT_FACES[i]
  FACES = ["north", "west", "south", "east"]
  RIGHT_FACES = ["east", "north", "west", "south"]
  LEFT_FACES = ["west", "south", "east", "north"]

  # move step: in case the move step is modified
  MOVE_STEP = 1

end