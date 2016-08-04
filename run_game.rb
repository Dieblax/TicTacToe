require_relative 'game'
require_relative 'player'
require_relative 'ai'

again = true

puts `clear`
puts "Welcome to Tic Tac Toe".center(50, " ")
puts "\nWhich mode do you want to play? (1 / 2 / 3 / 4)\n"
puts "1. Human vs Human"
puts "2. Human vs Computer"
puts "3. Computer vs Human"
puts "4. Computer vs Computer"
mode = gets.strip.to_i

case mode
when 1
	p1 = Player.new(:x)
	p2 = Player.new(:o)
when 2
	p1 = Player.new(:x)
	p2 = AI.new(:o)
when 3
	p1 = AI.new(:x)
	p2 = Player.new(:o)
when 4
	p1 = AI.new(:x)
	p2 = AI.new(:o)
end

game = Game.new(p1, p2)

while again
	
	Player.clear
	AI.clear
	game.clear

	current_player = p1
	until game.over?
		
		game.play(current_player)

		if current_player == p1
			current_player = p2
		else
			current_player = p1
		end

	end
	puts "Do you want to play again? (y/n)"

	input = gets.strip.downcase

	if input == "y"
		again = true
	else
		p1.stats
		p2.stats
		puts "Nice game, see you later!\n"
		again = false
	end

end