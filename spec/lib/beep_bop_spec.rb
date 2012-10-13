$LOAD_PATH.unshift File.expand_path('../../../lib/beep_bop/',__FILE__)
require 'beep_bop'

describe 'Beep Bop' do 

	let(:robot) {BeepBop.new}

	it 'should place the toy down to 0,0,NORTH' do
		robot.place(0,0,'NORTH')
		robot.x.should == 0
		robot.y.should == 0
		robot.f.should == 'NORTH'
	end

	it 'should not be on the table before a place command' do
		robot.move
		robot.left
		robot.right
		robot.report
		robot.on_table.should == false
	end

	it 'should execute commands after being placed on the table' do
		robot.on_table.should == false
		robot.left
		robot.place(0,0,'NORTH')
		robot.on_table.should == true
	end

	it 'should move the toy one square east when placed on the table, turned right and moved' do
		robot.place(0,0,'NORTH')
		robot.right
		robot.move
		robot.x.should == 1
		robot.y.should == 0
		robot.f.should == 'EAST'
	end

	it 'should not be allowed on the floor' do
		robot.place(5,5,'NORTH')
		robot.on_table.should == false
	end

	it 'should not move off the table' do
		robot.place(4,4,'NORTH')
		robot.move
		robot.x.should == 4
		robot.y.should == 4
		robot.f.should == 'NORTH'
	end

	it 'should report position correctly after being placed on table' do
		robot.place(3,3,'NORTH')
		robot.report.should == "3,3 FACING: NORTH"
	end

	it 'should respond when not on the table' do
		robot.execute('report').should == "I'm not on the table"
	end

	it 'should respond when command not valid' do
		robot.place(4,4,'NORTH')
		robot.execute('foo').should == "Not a valid command"
	end
end