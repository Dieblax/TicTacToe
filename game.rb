class Game
	def initialize
		@cases = 
						[
							[" ", " ", " "],
							[" ", " ", " "],
							[" ", " ", " "]
						]
	end

	def display
		puts `clear`
		puts "   A   B   C"
		@cases.each_with_index do |row, i|
			puts "#{i + 1}  #{row[0]} | #{row[1]} | #{row[2]} "
			puts "  " + "-" * 11 unless i == 2
		end
	end
	
end