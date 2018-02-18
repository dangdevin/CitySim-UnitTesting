require_relative "location"
require_relative "driver"

def city_sim(seed, driver)
	monroeville = Location.new("Monroeville", nil, nil, nil, nil)
	downtown = Location.new("Downtown", nil, nil, nil, nil)
	cathedral = Location.new("Location", "Fourth", "Bar", nil, @monroeville)
	hospital = Location.new("Hospital", "Fourth", "Foo", nil, @cathedral)
	museum = Location.new("Museum", "Fifth", "Bar", @hillman, nil)
	hillman = Location.new("Hillman", "Fifth", "Foo", @downtown, @museum)

	locations = [hospital, cathedral, hillman, museum];

	driver_one = Driver.new("Driver 1", 1, 0, 0)
	driver_two = Driver.new("Driver 2", 1, 0, 0)
	driver_three = Driver.new("Driver 3", 1, 0, 0)
	driver_four = Driver.new("Driver 4", 1, 0, 0)
	driver_five = Driver.new("Driver 5", 1, 0, 0)

	drivers = [driver_one, driver_two, driver_three, driver_four, driver_five]
end
