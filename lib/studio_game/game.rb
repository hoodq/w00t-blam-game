require_relative "player" #relative meaning that player.rb is in the same folder as game.rb
require_relative "die"
require_relative "game_turn"
require_relative "treasure_trove"

module StudioGame
	class Game
		attr_reader :title

		def initialize(title)
			@title = title.capitalize
			@players = []
		end

		def load_players a_file
			File.readlines(a_file).each do |line|
				add_player(Player.from_csv(line))
			end
		end

		def add_player(a_player)
			@players.push(a_player)
		end

		def total_points
			@players.reduce(0) { |sum, player| sum + player.points}
		end

		def play(rounds)
			puts "There are #{@players.length} players in #{@title}"
			@players.each do |player|
				puts player
			end

			treasures = TreasureTrove::TREASURES 	#we don't necessarily need the local variable treasures but it makes using the array constant easier
		
			puts "\nThere are #{treasures.length} treasures to be found:"
		
			treasures.each do |treasure|
				puts "A #{treasure.name} is worth #{treasure.points} points"
			end

			1.upto(rounds) do |round|
				if block_given? 				#if a block is given when the play method is called
					break if yield				#break out of this loop if yield (or if the value that the block returns) is true
				end
				puts "\nRound #{round}:"
				@players.each do |player|
					GameTurn.take_turn(player)
				end
			end
		end

		def print_name_and_health(player)
			"#{player.name} (#{player.health})"
		end

		def print_stats
			strong_players , wimpy_players = @players.partition {|player| player.strong?}

			puts "\n#{@title} Statistics:"

			puts "\n#{strong_players.length} strong player(s)"
			strong_players.each do |player|
				puts print_name_and_health(player)
			end

			puts "\n#{wimpy_players.length} wimpy player(s)"
			wimpy_players.each do |player|
				puts print_name_and_health(player)
			end

			puts "\n #{@title} High Scores:"
			@players.sort.each do |player|
				puts high_score_entry(player)
			end

			@players.each do |player|
				puts "\n#{player.name}'s point totals:"
				player.each_found_treasure do |treasure|
					puts "#{treasure.points} total #{treasure.name} points"
				end
				puts "#{player.points} grand total points"
			end

			puts "#{total_points} total points from treasure found"
		end

		def save_high_scores a_file="high_scores.txt"
			File.open(a_file, "w") do |file|
				file.puts "#{@title} High Scores:"
				@players.sort.each do |player|
					file.puts high_score_entry(player)
				end
			end
		end

		def high_score_entry player
			"#{player.name.ljust(20, '.')} #{player.score}"
		end
	end
end

if __FILE__ == $0
	player1 = Player.new('misty', 85)

	player2 = Player.new('brock', 40)

	game1 = Game.new('pokemon')
	game1.add_player(player1)
	game1.add_player(player2)
	game1.play
end