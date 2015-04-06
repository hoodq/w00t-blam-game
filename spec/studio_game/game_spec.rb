require "studio_game/game"
require_relative "spec_helper"

module StudioGame
	describe Game do
		before do
			@game = Game.new("Knuckleheads")

			@initial_health = 100
			@player = Player.new("moe", @initial_health)

			@game.add_player(@player)

			$stdout = StringIO.new
		end

		it "w00ts a player when a high number is rolled" do
			Die.any_instance.stub(:roll).and_return(5)

			@game.play(2)

			@player.health.should == @initial_health + (15 * 2)
		end

		it "skips a player when a medium number is rolled" do
			Die.any_instance.stub(:roll).and_return(3)

			@game.play(2)

			@player.health.should == @initial_health
		end

		it "blams a player when a low number is rolled" do
			Die.any_instance.stub(:roll).and_return(1)

			@game.play(2)

			@player.health.should == @initial_health - (10 * 2)
		end

		it "assigns a treasure for points during a player's turn" do
			game = Game.new("knuckleheads")
			player = Player.new("moe")

			game.add_player(player)

			game.play(1)

			player.points.should_not == 0
		end

		it "computes total points as the sum of all player points" do
			game = Game.new("knuckleheads")

			player1 = Player.new("moe")
			player2 = Player.new("larry")

			game.add_player(player1)
			game.add_player(player2)

			player1.found_treasure(Treasure.new(:hammer, 50))
			player1.found_treasure(Treasure.new(:hammer, 50))
			player2.found_treasure(Treasure.new(:pie, 10))

			game.total_points.should == 110
		end
	end
end