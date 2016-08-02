class Game 

	def initialize
		@cases = 
						[
							[" ", " ", " "],
							[" ", " ", " "],
							[" ", " ", " "]
						]
		@pos_hash = Hash.new { |h, k| h[k] = [] }
		display
	end

	def play(player, sym)
		puts "Player #{player}, it's your turn."
		begin
			puts "Where do you want to play? (e.g. A1)"
			pos = gets.strip
			pos = pos.split("")
			y = pos[0].downcase.ord - 97
			x = pos[1].to_i - 1
			if @cases[x][y] != " "
				raise "Illegal move"
			end
			@cases[x][y] = sym.to_s.downcase
		rescue 
			puts "It's an illegal move!\n"
			retry
		end
		display
	end

	def over?
		state_update

		if win?(:x)
			puts "Player 1 wins!\n"
		elsif win?(:o)
			puts "Player 2 wins!\n"
		elsif draw?
			puts "It's a draw...\n"
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
	end

	# updates @pos_hash which contains all positions occupied by both :x and :o
	def state_update

		@cases.each_with_index do |row, i|
			row.each_with_index do |pos, j|
				@pos_hash[pos.to_sym].push([i, j])
			end
		end

	end

	def win?(sym)
		if vertical_win?(@pos_hash[sym]) || horizontal_win?(@pos_hash[sym]) || diagonal_win?(@pos_hash[sym])
			return true
		end
		return false
	end

	def vertical_win?(arr)
		counter = Hash.new { |h, k| h[k] = 0 }
		arr.each do |x, y|
			p counter # to delete
			counter[y] += 1
		end
		win = false
		(0..2).each do |y|
			if counter[y] == 3
				puts "Vertical win, hash : #{counter}" # to delete
				win = true 
			end
		end
		return win
	end

	def horizontal_win?(arr)
		counter = Hash.new { |h, k| h[k] = 0 }
		arr.each do |x, y|
			p counter # to delete
			counter[x] += 1
		end
		win = false
		(0..2).each do |x|
			if counter[x] == 3
				puts "Horizontal win, hash : #{counter}" # to delete
				win = true 
			end
		end
		return win
	end

	def diagonal_win?(arr)
		corners = {top_left: [0, 0], top_right: [0, 2], bottom_left: [2, 0], bottom_right: [2, 2]}
		left_right = [corners[:top_left], corners[:bottom_right]]
		right_left = [corners[:top_right], corners[:bottom_left]]
		if arr.include?([1, 1])
			if left_right.all? {|corner| arr.include?(corner)} || right_left.all? {|corner| arr.include?(corner)}
				puts "Diagonal win, hash : #{counter}" # to delete
				return true
			end
		else
			return false
		end
	end

	def draw?
		if @cases.any? {|row| row.include?(" ")}
			return false
		else
			return true
		end
	end

end