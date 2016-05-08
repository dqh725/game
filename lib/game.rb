require_relative "game/version"
require_relative "robot"
require_relative "command"

module Game
  
  # the ToyRobot game object, the main class
  class ToyRobot

    # default read command fron STDIN, can feed with file pointer
    def initialize input_source= STDIN
      @input_source = input_source
      @robot = Robot.new
      @command = Command.new @robot
    end

    # start the game with infinite loop until 'exit' command
    def start
      if @input_source==STDIN
        puts "Enter commands: (type \"exit\" to quit; \"option\" for help)"
      end
      command = @input_source.gets.chomp
      while command and (command.chomp.downcase !="exit")
        command.chomp!
        process command if !command.empty?
        command = @input_source.gets
      end
    end

    private
      # ignore comment line "#" 
      # split command line into command and argument, and execute it.
      def process command
        # ignore comment line and puts out
        if command.strip[0] == "#"
          puts command
          return
        end

        # ["place", "1, 2, north"]
        instruction = command.split(" ",2)
        command_type = instruction[0].downcase

        # 'place' arguments validation is handled in command Class.
        # the other commands should have no input, is validated in this methods
        begin

          if instruction[1].nil?
            @command.send(command_type)
          else
            args = instruction[1].split(",").map{|var| var.strip}
            @command.send(command_type, *args)
          end

        rescue ArgumentError
          puts "=> Wrong number of arguments, illegal \"#{instruction[1]}\" for "\
           + command_type
        rescue NoMethodError
          puts "=> Unknown command: "+command_type

        end
      end
  end
end
