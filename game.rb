class Game 
require_relative 'tic_tac_toe_board'
include TicTacToeBoard
	def initialize(p1, p2)
		@cases = 
						[
							[" ", " ", " "],
							[" ", " ", " "],
							[" ", " ", " "]
						]
		@pos_hash = Hash.new { |h, k| h[k] = [] }
		display
		@players = [p1, p2]
		@stats = {p1: [0, 0, 0], p2: [0, 0, 0]}
	end

	def play(player, sym)
		
		begin
			pos = player.play(@pos_hash)
			pos = to_coordinates(pos)
			x = pos[0]
			y = pos[1]
			if @cases[x][y] != " " 
				raise "Illegal move"
			end
			@pos_hash[sym].push([x, y])
			@cases[x][y] = sym.to_s.downcase
		rescue Exception=>e
			puts "Caughts : #{e}"
			puts "It's an illegal move!\n"
			sleep 2
			retry
		end
		display
	end

	def over?

		if win?(@players[0].symbol)
			puts "Player 1 wins!"
			@stats[:p1][0] += 1
			@players[0].victories = @stats[:p1][0]
			@stats[:p2][1] += 1
			@players[1].losses = @stats[:p2][1]
		elsif win?(@players[1].symbol)
			puts "Player 2 wins!"
			@stats[:p1][1] += 1
			@players[1].victories = @stats[:p2][0]
			@stats[:p2][0] += 1
			@players[0].losses = @stats[:p1][1]
		elsif draw?
			puts "It's a draw...\n\n"
			@stats[:p1][2] += 1
			@stats[:p2][2] += 1
			@players.each { |player| player.ties = @stats[:p1][2] }
		else
			return false
		end

		return true

	end

	private

	def display
		puts `clear`
		puts "   A   B   C"
		@cases.each_with_index do |row, i|
			puts "#{i + 1}  #{row[0]} | #{row[1]} | #{row[2]} "
			puts "  " + "-" * 11 unless i == 2
		end
		puts "\n"
	end

	def win?(sym)
		POSSIBLE_WINS.each do |win|
			if win.all? { |pos| @pos_hash[sym].include?(pos) }
				return true
			end
		end
		return false
	end

	def draw?
		if @cases.any? {|row| row.include?(" ")}
			return false
		else
			return true
		end
	end

end