module TicTacToeBoard

	TL_CORNER = [0, 0]
	TR_CORNER = [0, 2]
	BL_CORNER = [2, 0]
	BR_CORNER = [2, 2]
	CORNERS = [TL_CORNER, TR_CORNER, BL_CORNER, BR_CORNER]

	CENTER = [1, 1]

	TOP_EDGE = [0, 1]
	LEFT_EDGE =[1, 0]
	RIGHT_EDGE = [1, 2]
	BOTTOM_EDGE = [2,1]
	SIDES = [TOP_EDGE, BOTTOM_EDGE, LEFT_EDGE, RIGHT_EDGE]

	FORK_NODES = [TL_CORNER, TR_CORNER, BL_CORNER, BR_CORNER, CENTER]

	POSSIBLE_WINS = 
							[
								[[0, 0], [0, 1], [0, 2]],
								[[1, 0], [1, 1], [1, 2]],
								[[2, 0], [2, 1], [2, 2]],
								[[0, 0], [1, 0], [2, 0]],
								[[0, 1], [1, 1], [2, 1]],
								[[0, 2], [1, 2], [2, 2]],
								[[0, 0], [1, 1], [2, 2]],
								[[0, 2], [1, 1], [2, 0]]
							]

	def opposite(corner)
		opposite =
					corner.map do |x|
						if x == 2
							x = 0
						else
							x = 2
						end
					end
		return opposite
	end

	def opponent_sym(sym)
		if sym == :x
			return :o
		else
			return :x
		end
	end

	def to_coordinates(pos)
		x = pos[1].to_i - 1
		y = pos[0].downcase.ord - 97
		return [x, y]
	end

	def to_letters(pos)
		x = pos[0] + 1
		y = (pos[1] + 65).chr
		return [y, x]
	end

end