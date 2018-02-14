require_relative "city"

class CitySim9006

def genRandNumber
	if ARGV[0].to_i == nil
		rand = Random.new_seed
	end
end

raise "Enter a proper seed integer and only that at the command line" unless ARGV.count == 1