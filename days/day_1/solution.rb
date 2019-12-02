# fuel = (mass / 3.0).floor - 2
# read in file
# get fuel for each module
# return result
#

# part 1
def calculate_fuel_for_file(path)
  masses = File.read(path).split("\n").map(&:to_i)
  total = masses.reduce(0) { |total, mass| total + calculate_fuel(mass) }

  puts "total is #{total}"
end

def calculate_fuel(mass)
 fuel = (mass / 3) - 2

 if fuel <= 0
   fuel
 elsif (fuel_for_fuel = calculate_fuel(fuel)) > 0
   fuel + fuel_for_fuel
 else
   fuel
 end
end

# part 2
#
calculate_fuel_for_file(ARGV.first)
