require_relative "../lib/robot"
require_relative "../lib/command"
require_relative "spec_helper"

describe Command do
	let(:robot) { Robot.new }
	let(:command) { Command.new }

	describe 'place module: ' do
		context "illegal place:\n" do
			# wrong_type, illegal_value
			negative_tests=
				[ nil,
					[],
					[1],
					[1,1,"east","",""],
					[ nil, nil, nil ], 
					[ 0, 5, "EasT"], 
					[ 0, 0, "f" ], 
					[ -1, 1, "norTH" ]
				]
			positive_tests = 
				[
					[1,1,'norTh'],
					[2,4, 'East'],
					[2,4, 'west'],
					[2,4, 'SOUTH']
				]

			negative_tests.each do |test|		
				it "#{test} should raise error." do
					expect {command.take(robot).extend(Place).execute(*test)}.to \
						raise_error(RuntimeError)
				end
			end
			positive_tests.each do |test|		
				it "#{test} should pass." do
					expect {command.take(robot).extend(Place).execute(*test)}.not_to \
						raise_error
				end
			end
		end 

		context "legal place:\n" do
			# wrong_type, illegal_value
			tests=[ [ nil, nil, nil ], 
							[ 0, 5, "EasT"], 
							[ 0, 0, "f" ], 
							[ -1, -1, "norTH" ] ]

			tests.each do |test|		
				it "#{test} should raise error." do
					expect {command.take(robot).extend(Place).execute(test)}.to \
						raise_error(RuntimeError)
				end
			end
		end 
	end

	describe "move module: " do
		context "before place:\n" do

			it "should ignore move:\n" do
				command.take(robot).extend(Move).execute
				expect(robot.x).to eq(nil)
			end
		end

		context "initialise with place:\n" do

			# all test case of move in "place_followed_by_move.txt"
			# each line has 6 fields, seperated by ','
			# command: place (0, 1, 2) and move, expect: field (3, 4, 5)

			f=File.new("#{File.dirname(__FILE__)}/tests/place_and_move.txt",'r')
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

	describe "left/right modules: " do

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