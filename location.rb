class Location
	# Create new locations
	attr_accessor :location, :avenue, :street, :forward_path, :turn_path
	def initialize(location, avenue, street, forward_path, turn_path)
		@location = location
		@avenue = avenue
		@street = street
		@forward_path = forward_path
		@turn_path = turn_path
	end
end