require_relative "game/version"
require_relative "robot"
require_relative "command"

module Game
  
  # the ToyRobot game object, the main class
  class ToyRobot
		def initialize input_source= STDIN
			@input_source = input_source
			@robot = Robot.new
			@command = Command.new @robot
		end

		# start the game
		def start
			puts "enter commands: (hit \"exit\" to quit)" if @input_source==STDIN
			command = @input_source.gets.chomp
			while command and (command.chomp.downcase !="exit")
				command.chomp!
				process command if !command.empty?
				command = @input_source.gets
			end
		end

		private
		# after reading a line from input, process the command
		# ignore error operation or operate the robot
	    def process command
	    	instruction = command.split(" ",2);
	    	command_type = instruction[0].capitalize
	    	if Constants::REGISTERED_COMMANDS.index(command_type.downcase)

	    		if instruction[1].nil?
	    			@command.extend(Module.const_get command_type).execute
	    		else
	    			args = instruction[1].split(" ")
	    			@command.extend(Module.const_get command_type).execute(*args)
	    		end
	    		
	    	else
	    		puts "Unknown command: "+command_type
	    	end
	    end
	end
end
