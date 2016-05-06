require_relative "../lib/robot"
require_relative "../lib/command"
require_relative "spec_helper"

describe Command do
	let(:robot) { Robot.new }
	let(:command) { Command.new }
	describe "move operation:" do
		context "before place:\n" do

			it "should ignore move:\n" do
				command.take(robot).extend(Move).execute
				expect(robot.x).to eq(nil)
			end
		end

		context "initialise with place:\n" do
			# all test case of move in "move.txt"
			
			f=File.new("#{File.dirname(__FILE__)}/tests/move.txt",'r')
			lines = f.read.split("\n")
			# puts commands.to_s
			lines.each do |string_line|
				it "should not move forward:" do
					line = string_line.split(",")
					# puts line.to_s
					robot.place(line[0].to_i,line[1].to_i,line[2])
					command.take(robot).extend(Move).execute

					expect(robot.x).to eq(line[3].to_i)
					expect(robot.y).to eq(line[4].to_i)
					expect(robot.face.upcase).to eq(line[5])
				end
			end
			f.close
		end
	end

	describe "left/right:" do

		#ignore left and right before place
		context "before place:\n" do
			it "should ignore left" do
				command.take(robot).extend(Left).execute
				expect(robot.face).to eq(nil)
			end
			it "should ignore right" do
				command.take(robot).extend(Right).execute
				expect(robot.face).to eq(nil)
			end
		end

		context "after place:\n" do
			faces = ["NORTH","WEST","SOUTH","EAST"]  #current face
			rightout = ["EAST","NORTH","WEST","SOUTH"]  # turn right face
			leftout = ["WEST","SOUTH","EAST","NORTH"]	# ture left face
			(0..3).each do |i|
				it "#{faces[i]} should turn right" do
					robot.place(0,0,faces[i])
					command.take(robot).extend(Right).execute
					expect(robot.face.upcase).to eq(rightout[i])
				end
				it "#{faces[i]} should turn left" do
					robot.place(0,0,faces[i])
					command.take(robot).extend(Left).execute
					expect(robot.face.upcase).to eq(leftout[i])
				end
			end
		end

	end

end