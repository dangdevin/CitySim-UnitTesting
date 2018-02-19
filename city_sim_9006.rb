require_relative "location"
require_relative "driver"

class CitySim
	def self.initialize(seed)
		@prng = Random.new(seed)

		@monroeville = Location.new("Monroeville", nil, nil, nil, nil)
		@downtown = Location.new("Downtown", nil, nil, nil, nil)
		@cathedral = Location.new("Cathedral", "Fourth", "Bar", @monroeville, nil)
		@hospital = Location.new("Hospital", "Fourth", "Foo", @cathedral, nil)
		@hillman = Location.new("Hillman", "Fifth", "Foo", @downtown, @hospital)
		@museum = Location.new("Museum", "Fifth", "Bar", @hillman, @cathedral)

		@cathedral.turn_path = @museum
		@hospital.turn_path = @hillman

		@locations = [@hospital, @cathedral, @hillman, @museum];

		@driver_one = Driver.new("Driver 1", 1, 0, 0)
		@driver_two = Driver.new("Driver 2", 1, 0, 0)
		@driver_three = Driver.new("Driver 3", 1, 0, 0)
		@driver_four = Driver.new("Driver 4", 1, 0, 0)
		@driver_five = Driver.new("Driver 5", 1, 0, 0)

		@drivers = [@driver_one, @driver_two, @driver_three, @driver_four, @driver_five]
	end



	def self.setLocation()
		@current_location = @locations[@prng.rand(4)]
	end

	def self.checkCurrentLocation(driver)
		if(@current_location == @cathedral)
			driver.num_classes *= 2
		elsif (@current_location == @hillman)
			driver.num_books += 1
		elsif (@current_location == @museum)
			driver.num_toys += 1
		end
	end

	def self.printResult(driver)
		puts "#{driver.driver_name} obtained #{driver.num_books} books!"
		puts "#{driver.driver_name} obtained #{driver.num_toys} dinosaur toys!"
		puts "#{driver.driver_name} attended #{driver.num_classes} classes!"
	end

	def self.printLocation(driver, way)
		if (way == 0)
			puts "#{driver.driver_name} heading from #{@current_location.location} to #{@current_location.forward_path.location} via #{@current_location.street}"
			@current_location = @current_location.forward_path
		else (way == 1)
			puts "#{driver.driver_name} heading from #{@current_location.location} to #{@current_location.turn_path.location} via #{@current_location.street}"
			@current_location = @current_location.turn_path
		end
	end

	def self.simDrive(driver)
		while @current_location != @monroeville and @current_location != @downtown
			@way = @prng.rand(2)
			checkCurrentLocation(driver)
			printLocation(driver, @way)
		end
		printResult(driver)
	end

	def self.run()
		for driver in @drivers
			setLocation()
			simDrive(driver)
		end
	end

	def self.argpass()
		args = ARGV
		return args.to_a
	end

	def self.argchecker(args)
		if(args.length == 1)
			if (args[0].to_i < 0)
				@seed = 0
			else
				@seed = args[0].to_i
			end
			citySim = initialize(@seed)
			run()
		else
			abort("Error: argument invalid")
		end
		return @seed
	end

	argchecker(argpass)
end
