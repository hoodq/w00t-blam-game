require 'studio_game/berserk_player'
require_relative 'spec_helper'

module StudioGame
	describe BerserkPlayer do
		before do
			@initial_health = 50
			@player = BerserkPlayer.new('berserker', @initial_health)
			$stdout = StringIO.new
		end

		it "does not go berserk when w00ted up to 5 times" do
			1.upto(5) { @player.w00t }

			@player.berserk?.should == false
		end

		it "goes berserk when w00ted 6 times or more" do
			1.upto(6) { @player.w00t }

			@player.berserk?.should == true
		end

		it "gets w00ted insted of blammed when it's gone berserk" do
			1.upto(6) { @player.w00t }
			1.upto(2) { @player.blam }

			@player.health.should == @initial_health + (8 * 15)
		end
	end
end