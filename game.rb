class Game

	require_relative "player"
	require_relative 'ai'
	require_relative 'tic_tac_toe_module'
	include TicTacToe

	def initialize(p1, p2)		
		clear
		@players = [p1, p2]
		@stats = {p1: [0, 0, 0], p2: [0, 0, 0]}
	end

	def clear
		@board = [" "]*9
		display
	end

	def play(player)
		begin
			pos = player.play(@board)
			unless @board[pos] == " " 
				raise "Illegal move"
			end
			@board[pos] = player.symbol.to_s.downcase 
		rescue Exception=>e
			puts "Caught : #{e}"
			puts "It's an illegal move!\n"
			sleep 1.5
			retry
		end
		display
	end

	def over?

		if win?(@players[0].symbol)
			puts "#{@players[0].name} wins!"
			@stats[:p1][0] += 1
			@players[0].victories = @stats[:p1][0]
			@stats[:p2][1] += 1
			@players[1].losses = @stats[:p2][1]
		elsif win?(@players[1].symbol)
			puts "#{@players[1].name} wins!"
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
		puts "1  #{@board[0]} | #{@board[1]} | #{@board[2]} "
		puts "2  #{@board[3]} | #{@board[4]} | #{@board[5]} "
		puts "3  #{@board[6]} | #{@board[7]} | #{@board[8]} "
		puts "\n"
	end

	def win?(sym)
		POSSIBLE_WINS.each do |win|
			if win.all? { |pos| @board[pos] == sym.to_s }
				return true
			end
		end
		return false
	end

	def draw?
		if @board.any? { |mark| mark == " " }
			return false
		else
			return true
		end
	end

end