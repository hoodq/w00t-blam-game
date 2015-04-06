require_relative "die"
require_relative "player"
require_relative "treasure_trove"

module StudioGame
	module GameTurn
		def self.take_turn(player)
			die = Die.new
			case die.roll
			when 1..2
				player.blam
			when 3..4
				puts "#{player.name} was skipped."
			when 5..6
				player.w00t
			end

			randTreasure = TreasureTrove.random
			player.found_treasure(randTreasure)
		end
	end
end