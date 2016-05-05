# author: Alba
# date: 4/May/2016
#   before run this test code,  need uncomment the 
#   "# attr_accessor :x, :y, :face " in robot class

require_relative "../lib/robot"
require "spec_helper"

describe Robot do
	describe "place(x,y,face) " do
		let(:robot) { Robot.new  }

		context "without place command:\n" do
			it "all shuold be nil" do
				expect(robot.x).to eq(nil)
				expect(robot.y).to eq(nil)
				expect(robot.face).to eq(nil)
			end
		end

		context "with place command:\n" do
			before  { robot.place(0,0,"north")}
			it "x, y should be integer" do
				expect(robot.x.class).to eq(Fixnum)
				expect(robot.y.class).to eq(Fixnum)
			end
			it "face should be string" do
				expect(robot.face.class).to eq(String)
			end
		end

		context "illegal variable of place:\n" do
			# wrong_type, illegal_value
			tests=[ [ nil, nil, nil ], 
							[ 0, 5, "EasT"], 
							[ 0, 0, "f" ], 
							[ -1, -1, "norTH" ] ]

			tests.each do |test|		
				it "#{test} should raise error." do
					expect{robot.place(test[0], test[1], test[2])}.to raise_error(RuntimeError)
				end
			end
		end

		



	end

end