module TicTacToe
	POSSIBLE_WINS = [
						[0, 1, 2], [3, 4, 5], [6, 7, 8], 
						[0, 3, 6], [1, 4, 7], [2, 5, 8], 
						[2, 4, 6], [0, 4, 8]
									]

	CORNERS = [0, 2, 6, 8]

	SIDES = [1, 3, 5, 7]

	def board_pos(i, j)
		fake_board = [
										[0, 1, 2],
										[3, 4, 5],
										[6, 7, 8]
								 ]

		return fake_board[i][j]
	end

	def opponent_symbol(sym)
		sym == :x ? :o : :x
	end

	def opposite(corner)
		case corner
		when 0 then 8
		when 2 then 6
		when 6 then 2
		when 8 then 0
		end
	end

	def legal?(board, pos)
		if pos
			board[pos] == " " ? true : false
		else
			false
		end
	end

end