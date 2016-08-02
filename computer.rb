class Computer < Player
require_relative 'player'
require_relative 'tic_tac_toe_board'
include TicTacToeBoard
	def play(pos_hash)
		puts "Computer playing..."
		sleep 2
		if win(pos_hash)
			puts "Returning win"
			return to_letters(win(pos_hash))
		elsif block(pos_hash)
			puts "Returning block"
			return to_letters(block(pos_hash))
		# elsif fork(pos_hash)

		# elsif block_fork(pos_hash)

		elsif center(pos_hash)
			puts "Returning center"
			return to_letters(center(pos_hash))
		elsif opposite_corner(pos_hash)
			puts "Returning opposite corner"
			return to_letters(opposite_corner(pos_hash))
		elsif empty_corner(pos_hash)
			puts "Returning empty corner"
			return to_letters(empty_corner(pos_hash))
		elsif empty_side(pos_hash)
			puts "Returning empty_side"
			return to_letters(empty_side(pos_hash))
		else 
			puts "STUCK"
		end
			
	end

	private

	def win(pos_hash)
		#determine if the computer can win
		POSSIBLE_WINS.each do |win|
			matches = win & pos_hash[@symbol]
			missing = win - matches
			return missing if matches.size == 2
		end
		return false
	end

	def block(pos_hash)
		# determine if the computer can block the opponents's win
		POSSIBLE_WINS.each do |win|
			matches = win & pos_hash[opponent_sym(@symbol)]
			missing = win - matches
			return missing if matches.size == 2
		end
		return false
	end

	def fork(pos_hash)
		# determine if the computer can create a fork (create two threats to win)
	end

	def block_fork(pos_hash)
		# determine if the computer can block the opponent's fork
	end

	def center(pos_hash)
		# mark the center, if it's the first move it's better to play on a corner
		unless pos_hash.values.flatten(1).include?(CENTER) 
			return CENTER
		end
		return false
	end

	def opposite_corner(pos_hash)
		# if the opponent is in the corner, the computer plays on the opposite corner
		CORNERS.each do |corner|
			match = pos_hash.values.flatten(1).find(false) { |pos| pos == corner }
			return opposite(match) if match
		end
		return false
	end

	def empty_corner(pos_hash)
		# play on a corner
		CORNERS.each do |corner|
			unless pos_hash.values.flatten(1).include?(corner)
				return corner
			end
		end
		return false
	end

	def empty_side(pos_hash)
		# play on a middle square on any of the 4 sides
		SIDES.each do |side|
			unless pos_hash.values.flatten(1).include?(side)
				return side
			end
		end
		return false
	end

end