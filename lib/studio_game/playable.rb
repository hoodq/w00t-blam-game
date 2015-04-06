module StudioGame
	module Playable
		def w00t
			self.health += 15				#need self.health here since we are changing its value
											#if we simply put health, Ruby would treat health as a local variable instead of the class attribute we want
			puts "#{name} got w00ted!"		#don't need self.name here because we are simply reading it off (not changing it)
		end

		def blam
			self.health -= 10
			puts "#{name} got blammed!"
		end

		def strong?
			health > 100					#here, self.health is not necessary since we are simply querying it
		end
	end
end