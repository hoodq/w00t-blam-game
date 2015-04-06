require 'studio_game/clumsy_player'
require_relative 'spec_helper'

module StudioGame
	describe ClumsyPlayer do
		before do
			@initial_health = 105
			@boost_factor = 3
			@player = ClumsyPlayer.new('klutz', @initial_health, @boost_factor)
			$stdout = StringIO.new
		end

		it "only gets half the point value for each treasure" do
			@player.points.should == 0

			hammer = Treasure.new(:hammer, 50)
			@player.found_treasure(hammer)
			@player.found_treasure(hammer)
			@player.found_treasure(hammer)

			@player.points.should == 75

			crowbar = Treasure.new(:crowbar, 400)
			@player.found_treasure(crowbar)

			@player.points.should == 275

			yielded = Array.new
			@player.each_found_treasure do |treasure|
				yielded << treasure
			end

			yielded.should == [Treasure.new(:hammer, 75), Treasure.new(:crowbar, 200)]
		end

		it "gets w00ted the number of times equivalent to it's initial boost_factor" do
			@player.w00t
			@player.health.should == @initial_health + (@boost_factor * 15)
		end
	end
end