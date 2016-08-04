class AI
	require_relative 'tic_tac_toe_module'
	include TicTacToe

	@@count = 0
	attr_reader :symbol, :name
	attr_accessor :victories, :losses, :ties

	def self.clear
		@@count = 0
	end

	def initialize(sym)
		@@count += 1
		@symbol = sym
		if @@count == 1
			@name = "Computer" 
		else
			@name = "Computer #{@@count}"
		end
		@victories = 0
		@losses = 0
		@ties = 0
	end

	def play(board)
		puts "#{@name} playing..."
		sleep 0.2
		return win(board) if legal?(board, win(board))
		return block(board) if legal?(board, block(board))
		return fork(board) if legal?(board, fork(board))
		return block_fork(board) if legal?(board, block_fork(board))
		return center(board) if legal?(board, center(board))
		return opposite_corner(board) if legal?(board, opposite_corner(board))
		return empty_corner(board) if legal?(board, empty_corner(board))
		return empty_side(board) if legal?(board, empty_side(board))
		raise "Something went wrong when the computer was playing..."
	end

	def stats
		puts "\n#{@name}\n"
		puts "Victories : #{@victories}"
		puts "Ties : #{@ties}"
		puts "Losses : #{@losses}"
	end

	# private

	# 1. win : if player can win, play win move
	def win(board, sym = @symbol)
		POSSIBLE_WINS.each do |win|
			marks = board.each_index.select { |i| board[i] == sym.to_s }
			matches = win & marks
			if matches.size == 2
				missing = win - matches
				missing = missing[0]
				return missing unless board[missing] != " "
			end
		end
		return false
	end

	# 2. block : if opponent can win, play block move
	def block(board)
		POSSIBLE_WINS.each do |win|
			marks = board.each_index.select { |i| board[i] == opponent_symbol(@symbol).to_s }
			matches = win & marks
			if matches.size == 2
				missing = win - matches
				missing = missing[0]
				return missing unless board[missing] != " "
			end
		end
		return false
	end

	# 3. fork : if player can create 2 win threats, play fork
	def fork(board, sym = @symbol)
		fake_board = board
		(0..2).each do |i|
			row = [fake_board[i * 3], fake_board[(i * 3) + 1], fake_board[(i * 3) + 2]]
			if only_one_mark?(sym, row)
				# delete mark from board so that it doesn't get counted again in columns
				k = row.find_index(sym.to_s)
				del = board_pos(i, k)
				(0..2).each do |j|
					column = [fake_board[j], fake_board[j + 3], fake_board[j + 6]]
					if only_one_mark?(sym, column)
						move = board_pos(i, j)
						return move if board[move] == " " && move != del
					end
				end
			end
		end
		return false
	end

	# 4. block_fork : if opponent can create 2 win threats, play block_fork
	def block_fork(board)
		return fork(board, opponent_symbol(@symbol))
	end

	# 5. center : if the center piece is empty, play it unless it's the first move
	# if it's the first move (all marks are empty) play a corner
	def center(board)
		if board[4] == " "
			return 4
		else
			return false
		end
	end

	# 6. opposite_corner : if the opponent is on a corner, play the opposite corner
	def opposite_corner(board)
		CORNERS.each do |corner|
			if board[corner] == opponent_symbol(@symbol)
				move = opposite(corner)
				return move if board[move] == " "
			end
		end
		return false
	end

	# 7. empty_corner : if there is an empty corner, play it
	def empty_corner(board)
		CORNERS.each do |corner|
			if board[corner] == " "
				return corner
			end
		end
		return false
	end

	# 8. empty_side : if there is an empty side, play it
	def empty_side(board)
		SIDES.each do |side|
			if board[side] == " "
				return side
			end
		end
		return false
	end

	def only_one_mark?(mark, arr)
		return (arr.one? { |m| m == mark.to_s }) && (arr.none? { |m| m == opponent_symbol(mark).to_s })
	end

end