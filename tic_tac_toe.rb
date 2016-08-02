require_relative 'game'
require_relative 'player'

again = true

while again
	
	Player.clear
	p1 = Player.new(:x)
	p2 = Player.new(:o)
	game = Game.new(p1, p2)

	current_player = p1
	until game.over?
		
		game.play(current_player, current_player.symbol)

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