require_relative 'treasure_trove'
require_relative 'playable'

module StudioGame
	class Player
		include Playable

		attr_accessor :health
		attr_reader :name 		   #even though we can change name using an instance method, we don't need it in attr_accessor because
								   #we expicitly define the setter method name= later on in the player class

		def initialize(name, health=100)
			@name = name.capitalize
			@health = health
			@found_treasures = Hash.new(0)
		end

		def each_found_treasure
			@found_treasures.each do |key, value|
				yield Treasure.new(key, value)
			end
		end

		def found_treasure(treasure)
			@found_treasures[treasure.name] += treasure.points
			puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
		end

		def points
			@found_treasures.values.reduce(0, :+)
		end

		def score
			@health + points
		end

		def name=(new_name)
			@name = new_name.capitalize
		end

		def <=>(other_player) #<=> or the spaceship operator is originally defined in the fixnum class so by defining it here, we are overwriting it 
			other_player.score <=> score
		end

		def self.from_csv csv_string #use self because we are adding a player object in the player class 
			name, health = csv_string.split(', ')
			Player.new(name, Integer(health))
		end

		def to_s
			"I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}"
		end
	end
end

if __FILE__ == $0
	player = Player.new("moe")
	puts player.name
	puts player.health
	player.w00t
	puts player.health
	player.blam
	puts player.health
end