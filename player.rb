class Player
	@@count = 0

	attr_reader :number, :symbol
	attr_writer(:victories, :losses, :ties)

	def self.clear
		@@count = 0
	end

	def initialize(sym)
		@@count += 1
		@number = @@count
		@symbol = sym
		@victories = 0
		@losses = 0
		@ties = 0
	end

	def play(pos_hash)
		puts "Player #{@number}, it's your turn."
		puts "Where do you want to play? (e.g. A1)"
		pos = gets.strip.split("")
		return pos
	end

	def stats
		puts "\nPlayer #{number}\n"
		puts "Victories : #{@victories}"
		puts "Ties : #{@ties}"
		puts "Losses : #{@losses}"
	end

end

