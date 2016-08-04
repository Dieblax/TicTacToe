class Player

	@@count = 0
	attr_reader :symbol, :name
	attr_accessor :victories, :losses, :ties

	def self.clear
		@@count = 0
	end

	def initialize(sym)
		@@count += 1
		@name = "Player #{@@count}"
		@symbol = sym
		@victories = 0
		@losses = 0
		@ties = 0
	end

	def play(board)
		puts "#{@name}, it's your turn"
		puts "Where do you want to play? (e.g. A1)"
		letters = gets.strip
		return to_pos(letters)
	end

	def stats
		puts "\n#{@name}\n"
		puts "Victories : #{@victories}"
		puts "Ties : #{@ties}"
		puts "Losses : #{@losses}"
	end

	private

	def to_pos(letters)
		case letters.downcase
		when "a1" then 0
		when "b1" then 1
		when "c1" then 2
		when "a2" then 3
		when "b2" then 4
		when "c2" then 5
		when "a3" then 6
		when "b3" then 7
		when "c3" then 8
		end
	end

end