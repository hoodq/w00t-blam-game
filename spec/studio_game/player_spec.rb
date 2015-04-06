require 'studio_game/player'
require 'studio_game/treasure_trove'
require_relative 'spec_helper'

module StudioGame
	describe Player do
		before do
			@initial = 247
			@player1 = Player.new("alex", @initial)
			$stdout = StringIO.new #takes the output of class methods and stores them in this new object rather than to the screen, leaving the dots in tact
		end

		it "has a capitalized name" do
			@player1.name.should == "Alex"
		end

		it "has an initial health of 247" do
			@player1.health.should == @initial
		end

		it "has a string representation" do
			@player1.found_treasure(Treasure.new(:hammer, 50))
			@player1.found_treasure(Treasure.new(:hammer, 50))
		
			@player1.to_s.should == "I'm Alex with health = 247, points = 100, and score = 347"
		end

		it "computes a score as the sum of its health and points" do
			@player1.found_treasure(Treasure.new(:hammer, 50))
			@player1.found_treasure(Treasure.new(:hammer, 50))

			@player1.score.should == 347
		end

		it "increses health by 15 when w00ted" do
			@player1.w00t
			@player1.health.should == @initial + 15
		end

		it "decreased health by 10 when blammed" do
			@player1.blam
			@player1.health.should == @initial - 10
		end

		it "computes points as the sum of all treasure points" do
			@player1.points.should == 0

			@player1.found_treasure(Treasure.new(:hammer, 50))

			@player1.points.should == 50

			@player1.found_treasure(Treasure.new(:crowbar, 400))

			@player1.points.should == 450

			@player1.found_treasure(Treasure.new(:hammer, 50))

			@player1.points.should == 500
		end

		it "yields each found treasure and its total points" do
			@player1.found_treasure(Treasure.new(:skillet, 100))
			@player1.found_treasure(Treasure.new(:skillet, 100))
			@player1.found_treasure(Treasure.new(:hammer, 50))
			@player1.found_treasure(Treasure.new(:bottle, 5))
			@player1.found_treasure(Treasure.new(:bottle, 5))
			@player1.found_treasure(Treasure.new(:bottle, 5))
			@player1.found_treasure(Treasure.new(:bottle, 5))
			@player1.found_treasure(Treasure.new(:bottle, 5))

			yielded = Array.new
			@player1.each_found_treasure do |treasure|
				yielded << treasure
			end

			yielded.should == [
				Treasure.new(:skillet, 200),
				Treasure.new(:hammer, 50),
				Treasure.new(:bottle, 25)
			]
		end

		it "loads player stats from the given csv file" do
			player = Player.from_csv("larry, 100")  #call from_csv right on the player class because it is a self method

			player.name.should == "Larry"
			player.health.should == 100
		end

		context "player with initial health of 150" do
			before do
				@player = Player.new("timmy", 150)
			end

			it "is strong" do
				@player.strong?.should == true
			end
		end

		context "player with initial health of 100" do
			before do
				@player = Player.new("larry", 100)
			end

			it "is not strong" do
				@player.strong?.should == false
			end
		end

		context "in a collection of players" do
			before do
				@player1 = Player.new("hermione", 100)
				@player2 = Player.new("ron", 200)
				@player3 = Player.new("harry", 300)

				@players = [@player1, @player2, @player3]
			end

			it "is sorted in descending order" do
				@players.sort.should == [@player3, @player2, @player1]
			end
		end
	end
end