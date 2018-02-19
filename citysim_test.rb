require 'minitest/autorun'
require_relative 'city_sim_9006.rb'

class CitySimTest < MiniTest::Test
	
	# UNIT TESTS FOR METHOD city_sim_9006.rb, initialize(seed)
	
	# This unit test checks for a city with the four locations initialized
	def test_fun_city_locs
		@city = CitySim::new
		assert_equal "Catherdal", @city.cathedral.location
		assert_equal "Hospital", @city.hospital.location
		assert_equal "Hillman", @city.hillman.location
		assert_equal "Museum", @city.Museum.location
	end

	# This unit test checks for a city with Fourth and Fifth Ave and they are connected to the proper locations
	def test_fun_avenues
		@city = CitySim::new
		assert_equal "Fourth", @city.cathedral.avenue
		assert_equal "Fourth", @city.hospital.avenue
		assert_equal "Fifth", @city.hillman.avenue
		assert_equal "Fifth", @city.museum.avenue
	end

	# This unit test checks for a city with Foo St and Bar St and they are connected to the proper locations
	def test_fun_streets
		@city = CitySim::new
		assert_equal "Foo", @city.hillman.street
		assert_equal "Foo", @city.hospital.street
		assert_equal "Bar", @city.cathedral.street
		assert_equal "Bar", @city.museum.street
	end

	# This unit test checks that five drivers are in the city
	def test_fun_five_drivers
		@city = CitySim::new
		assert_equal 5, @city.drivers.length
	end

	# UNIT TESTS FOR METHOD city_sim_9006.rb, printLocation(driver, way)
	
	# This unit test checks that at each iteration a Driver will drive from the current Location to a possible Location
	def test_fun_iteration
		@city = CitySim::new
		driver = Driver.new("Driver 1", 1, 0, 0)
		@city.current_location = @city.cathedral
		assert_output(/Driver 3 heading from Cathedral to Monroeville via Fourth/, "") { @city.printLocation(driver, 0) }
	end

	# This unit test checks that the driver can exit to Monroeville
	def test_exit_to_monroeville
		@city = CitySim::new
		@city.initialize(0)
		driver = Driver.new("Driver 1", 1, 0, 0)
		@city.current_location = @city.cathedral
		assert_output(/Driver 1 heading from Cathedral to Monroeville via Fourth/, "") { @city.printLocation(driver, 0) }
	end

	# This unit test checks that the driver can exit to Downtown
	def test_exit_to_downtown
		@city = CitySim::new
		driver = Driver.new("Driver 1", 1, 0, 0)
		@city.current_location = @city.hillman
		assert_output(/Driver 1 heading from Hillman to Downtown via Fifth/, "") { @city.printLocation(driver, 0) }
	end

	# UNIT TESTS FOR METHOD city_sim_9006.rb, argschecker()

	# EDGE CASE:
	# If no argument is provided, system shall inform the user and exit
	def test_no_arg
		assert_output(nil, /Error: argument invalid/) {CitySim.argchecker()}
	end

	# EDGE CASE:
	# If more than one argument is provided, system shall inform the user and exit
	def test_more_than_one_seed
		assert_output(nil, /Error: argument invalid/) {CitySim.argchecker(1, 2)}
	end

	# EDGE CASE:
	# If the minimum argument value is provided, use it as a seed.
	def test_zero_seed
		assert_equal 0, CitySim.argschecker()
	end

	# If a value less than the minimum argument value is provided, use 0 as a seed.
	def test_negative_seed
		assert_equal 0, CitySim.argschecker(-1)
	end

	# UNIT TESTS FOR METHOD city_sim_9006.rb, checkCurrentLocation()
	
	# This unit test checks if the driver is at the Cathedral the number of classes will be multipled by 2.
	def test_num_classes_times_two_cathedral
		@city = CitySim::new
		driver = Minitest::Mock.new("test-driver")
		def driver.num_classes; 2; end	
		@city.current_location = @city.cathedral
		@city.checkCurrentLocation(driver)
		assert_equal 4, driver.num_classes
	end
	
	# This unit test checks if the driver is at the Museum, it adds a toy.
	def test_add_toy_museum
		@city = CitySim::new
		driver = Driver.new("Driver 1", 1, 0, 0)
		@city.current_location = @city.museum
		@city.checkCurrentLocation(driver)
		assert_equal 1, driver.num_toys
	end

	# This unit test checks if the driver is at Hillman, it adds a book.
	def test_add_books_hillman
		@city = CitySim::new
		driver = Driver.new("Driver 1", 1, 0, 0)
		@current_location = @hillman
		checkCurrentLocation(driver)
		assert_equal 1, driver.num_books
	end

	# UNIT TESTS FOR METHOD city_sim_9006.rb, printResult()

	# This unit test checks if the system prints the correct number of classes the driver has taken.
	def test_num_classes_check_cathedral
		@city = CitySim::new
		driver = Driver.new("Driver 2 ", 3, 0, 0)
		@city.current_location = @city.cathedral
		@city.checkCurrentLocation(driver)
		assert_output(/Driver 2 obtained 0 books!\nDriver 2 obtained 0 dinosaur toys!\nDriver 2 attended 6 classes!/, "") { @city.printResult(driver) }
	end

	# This unit test checks if the system prints the correct number of books the driver has obtained.
	def test_num_books_check_hillman
		@city = CitySim::new
		@city.initialize(0)
		driver = Driver.new("Driver 2 ", 1, 1, 0)
		@city.current_location = @city.hillman
		@city.checkCurrentLocation(driver)
		assert_output(/Driver 2 obtained 2 books!\nDriver 2 obtained 0 dinosaur toys!\nDriver 2 attended 1 classes!/, "") { @city.printResult(driver) }
	end

	# This unit test checks if the system prints the correct number of toys the driver has obtained.
	def test_num_books_check_hillman
		@city = CitySim::new
		driver = Driver.new("Driver 2 ", 1, 0, 1)
		@city.current_location = @city.museum
		@city.checkCurrentLocation(driver)
		assert_output(/Driver 2 obtained 0 books!\nDriver 2 obtained 2 dinosaur toys!\nDriver 2 attended 1 classes!/, "") { @city.printResult(driver) }
	end
end