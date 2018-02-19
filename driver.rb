class Driver
	#Create new driver
	attr_accessor :driver_name, :num_classes, :num_books, :num_toys
	def initialize(driver_name, num_classes, num_books, num_toys)
		@driver_name = driver_name
		@num_classes = num_classes
		@num_books = num_books
		@num_toys = num_toys
	end
end