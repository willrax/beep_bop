#!/bin/ruby

class BeepBop

	attr_accessor :y, :x, :f, :on_table

	# Start with the Robot off the table
	def initialize
		@on_table = false
	end

	# Accept and interpret incoming commands. Don't respond if not on table.
	def execute(command)
		if command=~/^place (.),(.),(.+)/i
			params = $1, $2, $3
			place($1, $2, $3)
		elsif command=~/^exit/i
			exit 0
		elsif @on_table
			case command
				when /^report/i
					report
				when /^move/i
					move
				when /^left/i
					left
				when /^right/i
					right
				else 
					"Not a valid command"
			end
		else
			"I'm not on the table"
		end
	end

	# Robot moves one space forward in the facing direction
	def move
		return unless @on_table
		case @f
			when /north/i
				@y = (@y + 1) unless @y == 4
			when /south/i
				@y = (@y - 1) unless @y == 0
			when /west/i
				@x = (@x - 1) unless @x == 0
			when /east/i
				@x = (@x + 1) unless @x == 4
		end
	end

	# Reports the location of the robot
	def report
		return unless @on_table
		"#{@x},#{@y} FACING: #{@f}"
	end

	# Move the robot to coords and facing a direction instantly
	def place(x,y,f)
		if x.to_i > 4 || x.to_i < 0 || y.to_i > 4 || y.to_i < 0
			return "Put me on the table"
		else
			@x, @y, @f = x.to_i, y.to_i, f
			@on_table = true
		end
	end

	# Robot face left
	def left
		return unless @on_table
		case @f
			when /north/i
				@f = 'WEST'
			when /south/i
				@f = 'EAST'
			when /west/i
				@f = 'SOUTH'
			when /east/i
				@f = 'NORTH'
		end
		return
	end

	# Robot face right
	def right
		return unless @on_table
		case @f
			when /north/i
				@f = 'EAST'
			when /south/i
				@f = 'WEST'
			when /west/i
				@f = 'NORTH'
			when /east/i
				@f = 'SOUTH'
		end
		return
	end

end