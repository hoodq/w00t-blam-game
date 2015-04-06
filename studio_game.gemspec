Gem::Specification.new do |s|
	s.name			= "studly_studs_studio_game"
	s.version		= "1.0.0"
	s.author		= "Quinn Brooker Hood"
	s.email			= "hoodq@colorado.edu"
	s.homepage		= "www.website.com"
	s.summary		= "game pinning players against eachother"
	s.description	= File.read(File.join(File.dirname(__FILE__), 'README'))
	s.licenses		= ['MIT']

	s.files			= Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
	s.test_tiles	= Dir["spec/**/*"]
	s.executables	= [ 'studio_game' ]

	s.required_ruby_version = '>=1.9'
	s.add_development_dependency = 'rspec'
end