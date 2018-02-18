class Location
	# Create new locations
	attr_accessor :avenue, :street, :left_path, :right_path
	def initialize(location, avenue, street, left_path, right_path)
		@location = location
		@avenue = avenue
		@street = street
		@left_path = left_path
		@right_path = right_path
	end
end