require_relative 'game'
require_relative 'player'

again = true
while again

	game = Game.new
	turn = 0
	until game.over?
		turn = (turn % 2)
		p turn
		(turn + 1).odd? ? sym = :x : sym = :o
		game.play(turn + 1, sym)
		turn += 1
	end

	again = false
end