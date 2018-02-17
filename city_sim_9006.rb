require_relative "city"

class CitySim9006

def genRandNumber
	if ARGV[0].to_i == nil
		randomSeed = Random.new_seed
	end
end

unless ARGV.count == 1 || ARGV.count == 0
	genRandNumber
	puts randomSeed
end
